variable "api_endpoint" {
  description = "Endpoint to connect Proxmox API"
  type = string
  default = "https://192.168.1.10:8006/api2/json"
}

variable "api_token" {
  description = "Token to connect Proxmox API"
  type        = string
  default     = "terraform@pve!terraform=39e2cbb4-c391-4839-a752-08eee63832a2"
}

variable "api_disable_tls" {
  description = "Disable TLS verification"
  type        = bool
  default     = true
}

variable "pm_user" {
  description = "Proxmox username"
  type = string
  default = "root"
}

variable "pm_password" {
  description = "Proxmox password"
  type = string
  default = ""
}

variable "target_node" {
  description = "Proxmox node"
  type        = string
  default     = "catlab"
}


variable "onboot" {
  description = "Auto start VM when node is start"
  type        = bool
  default     = true
}

variable "target_node_domain" {
  description = "Proxmox node domain"
  type        = string
  default = ""
}

variable "vm_hostname" {
  description = "VM hostname"
  type        = string
  default = ""
}

variable "domain" {
  description = "VM domain"
  type        = string
  default = "bingo.local"
}

variable "vm_tags" {
  description = "VM tags"
  type        = list(string)
  default = [ "ubuntu" ]
}

variable "template_tag" {
  description = "Template tag"
  type        = string
  default = "ubuntu"
}

variable "sockets" {
  description = "Number of sockets"
  type        = number
  default     = 1
}

variable "cores" {
  description = "Number of cores"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Number of memory in MB"
  type        = number
  default     = 2048
}

variable "vm_user" {
  description = "User"
  type        = string
  sensitive   = true
  default = "admin"
}

variable "disk" {
  description = "Disk (size in Gb)"
  type = object({
    storage = string
    size    = number
  })
  default = {
    storage = "local"
    size = 10
  }
}

variable "additionnal_disks" {
  description = "Additionnal disks"
  type = list(object({
    storage = string
    size    = number
  }))
  default = []
}

variable "nodes" {
  description = "Configuration for each node"
  type = map(object({
    ansible_host    : string
    vm_id           : number
    cores           : number
    memory          : number
    network_bridge  : string
  }))
}
