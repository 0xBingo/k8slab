terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.42.0"
    }
  }
}

provider "proxmox" {
  endpoint = var.api_endpoint
  api_token  = var.api_token
  insecure  = var.api_disable_tls

  ssh {
    agent    = true
    username = var.pm_user
  }
}
