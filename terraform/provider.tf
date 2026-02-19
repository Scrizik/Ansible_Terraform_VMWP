terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc07"  # <-- VERSION QUI MARCHE
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://192.168.1.200:8006/api2/json"
  pm_api_token_id     = "terraform@pve!tk"
  pm_api_token_secret = var.proxmox_token_secret
  pm_tls_insecure     = true
  pm_parallel         = 2  # Permet 2 VMs en parallèle
}
