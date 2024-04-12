# `node.tf` values

node_name = "lab"

nodes = {
  kmaster = {
    host_ip         = "192.168.1.110/24"
    gw              = "192.168.1.1"
    vm_id           = 110
    cores           = 2
    memory          = 3072 # 3GB
    network_bridge  = "vmbr0"
    role            = "master"
  },
  kworker1 = {
    host_ip         = "192.168.1.111/24"
    gw              = "192.168.1.1"
    vm_id           = 111
    cores           = 2
    memory          = 1536 # 1,5GB
    network_bridge  = "vmbr0"
    role            = "worker"
  },
  kworker2 = {
    host_ip         = "192.168.1.112/24"
    gw              = "192.168.1.1"
    vm_id           = 112
    cores           = 2
    memory          = 1536
    network_bridge  = "vmbr0"
    role            = "worker"
  }
  kworker3 = {
    host_ip         = "192.168.1.113/24"
    gw              = "192.168.1.1"
    vm_id           = 113
    cores           = 2
    memory          = 1536
    network_bridge  = "vmbr0"
    role            = "worker"
  }
}

datastore = "local-lvm"
template_vm_id = "9999"
