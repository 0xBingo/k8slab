resource "proxmox_vm_qemu" "node" {
  for_each = var.nodes

  name        = each.key
  target_node = "lab"
  vmid        = each.value.vm_id
  desc        = "VM for ${each.value.role}"

  clone       = "ubuntu-server-focal"
  onboot      = true
  agent       = 1
  os_type     = "cloud-init"

  cores       = each.value.cores
  sockets     = 1
  cpu         = "host"
  memory      = each.value.memory

  network {
    bridge = each.value.network_bridge
    model  = "virtio"
  }

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = "40G"
  }

  ipconfig0 = "ip=${each.value.host_ip}/24,gw=192.168.1.1"

  ciuser    = "nodeadm"
  ssh_user  = "root"
  sshkeys   = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmUr9EjfAU+uF1Z/fEge91JDW/a3GK2XQBfhKjCpJMDBtnoLQcWWRSROT0nXJ7sh6IM7K9/wjBgzDmBOY2BxBSbjYzdniTMub/r+e41Us82JbLt9fpo1OAH0q44EqzmuBz0VC0H+pIc1m7PqylS7rq3wgeNFWR5Qg8RHx7aUaSdeJLtyuwJzKHE+QGmbeogL0jeQ5nlYGEoMW9cNotifOG9DHmR4d7FjjqbyPHjsGZ4xVv1eCMOW/dIMOBJD+9KPHSSGaVImCLs2BVmAu5EHe0lKs0hRtqc2mbX4HtzRs/grrY2IVjTScFkDy7vMzRVBh6EpahkLORHtHRWwcRfC2J+aUSjyKQVjopzyoYpYiLR2C3pUhVss8rfL/3WJjGgQ+B6LHVcmrGCOlrd2pky2y5EfDfFluQlt1/SXl8PMAjEh0z21tmMjum4R8pR/KrNbKSV9XDtK6KSh9V9y2hnubV+WXp5VnobTOPWVQGND2gYFXOtnKZn00xeC1EuWsmD1FdoH36JLKZpLFL5Pzr6IWGn7AoOxjHrzJ5so+zJmthD/WUXnIA0MPYfuo2s7dihTcrHMutGrGZ1mO28pzp9pYG8OLI9meISXzq6xuZS+QenHgzQzSpmUZm2jLOIFDCCvtQ5t50oqLmpdR4jApx4L6rxNx33liQpwx0qGd86PY9Dw== root@localhost
  EOF
}
