# `main.tf` variables definition

variable "proxmox_api_url" {
  type = string
  description = "Proxmox API URL 'https://ip:port'"
}

variable "proxmox_api_token" {
  type        = string
  description = "Proxmox API token"
  sensitive   = true
}

# `node.tf` variables definition

variable "node_name" {
  type = string
  description = "Proxmox node name"
}

variable "nodes" {
  type = map(object({
    host_ip         : string
    gw              : string
    vm_id           : number
    cores           : number
    memory          : number
    network_bridge  : string
    role            : string
  }))
}

variable "template_vm_id" {
  type        = string
  description = "Proxmox template VM ID"
}

variable "datastore" {
  type = string
  description = "Proxmox datastore name"
}

variable "ssh_key" {
  type = string
  description = "SSH public key"
}
