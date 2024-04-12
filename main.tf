# Proxmox Provider
# ---
# Initial Provider Configuration for Proxmox

terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = ">= 0.39.0"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure = true
}
