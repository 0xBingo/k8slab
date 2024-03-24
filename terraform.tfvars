nodes = {
  kmaster = {
    ansible_host    = "192.168.1.101"
    vm_id           = 100
    cores           = 2
    memory          = 4096
    network_bridge  = "vmbr0"
    role            = "master"
  },
  knode1 = {
    ansible_host    = "192.168.1.102"
    vm_id           = 101
    cores           = 2
    memory          = 2048
    network_bridge  = "vmbr0"
    role            = "worker"
  },
  knode2 = {
    ansible_host    = "192.168.1.103"
    vm_id           = 102
    cores           = 2
    memory          = 2048
    network_bridge  = "vmbr0"
    role            = "worker"
  }
}
