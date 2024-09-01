resource "proxmox_virtual_environment_vm" "node" {
  for_each = var.nodes

  name        = each.key
  node_name   = var.node_name
  vm_id       = each.value.vm_id
  description = "VM for ${each.value.role}"

  started   = true
  on_boot   = true

  clone {
    vm_id        = var.template_vm_id  # Replace with actual VM ID of the template if needed
    datastore_id = var.datastore
  }

  connection {
    type = "ssh"
  }

  agent {
    enabled = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = each.value.host_ip
        gateway = each.value.gw
      }
    }

    user_account {
      username = "ubuntu"
      keys     = [var.ssh_key]
    }
  }

  cpu {
    type    = "host"
    cores   = each.value.cores
    sockets = 1
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = var.datastore
    file_format  = "raw"
    size         = 50 # GB
    interface    = "scsi0"
  }

  network_device {
    bridge   = each.value.network_bridge
    model    = "virtio"
  }
}
