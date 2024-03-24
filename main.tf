data "proxmox_virtual_environment_vms" "template" {
  node_name = var.target_node
  tags      = ["template", var.template_tag]
}

resource "proxmox_virtual_environment_file" "cloud_user_config" {
  for_each = var.nodes

  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data = file("cloud-init/userdata.yml")

    file_name = "${each.key}.${var.domain}-ci-user.yml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_meta_config" {
  for_each = var.nodes

  content_type = "snippets"
  datastore_id = "local-lvm"
  node_name    = var.target_node

  source_raw {
    data = templatefile("cloud-init/metadata.yml", {
      instance_id    = sha1(each.key)
      local_hostname = each.key
    })

    file_name = "${each.key}.${var.domain}-ci-meta_data.yml"
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each = var.nodes

  name      = each.key
  node_name = var.target_node
  clone {
    vm_id = each.value.vm_id
  }

  on_boot = var.onboot
  agent {
    enabled = true
  }

  tags = var.vm_tags

  cpu {
    type    = "host"
    cores   = each.value.cores
    sockets = var.sockets
  }

  memory {
    dedicated = each.value.memory
  }

  network_device {
    model   = "virtio"
    bridge  = each.value.network_bridge
  }

  disk {
    interface    = "scsi0"
    iothread     = true
    datastore_id = var.disk.storage
    size         = var.disk.size
    discard      = "ignore"
  }

  dynamic "disk" {
    for_each = var.additionnal_disks
    content {
      interface    = "scsi${1 + disk.key}"
      iothread     = true
      datastore_id = disk.value.storage
      size         = disk.value.size
      discard      = "ignore"
      file_format  = "raw"
    }
  }

  initialization {
    datastore_id         = "local"
    interface            = "ide2"
    user_data_file_id    = proxmox_virtual_environment_file.cloud_meta_config[each.key].id
    meta_data_file_id    = proxmox_virtual_environment_file.cloud_meta_config[each.key].id
  }
}
