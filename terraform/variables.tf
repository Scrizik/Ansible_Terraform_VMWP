variable "proxmox_token_secret" {
  type      = string
  sensitive = true
}

variable "environment" {
  description = "Environnement de déploiement (production ou staging)"
  type        = string
  default     = "production"
  
  validation {
    condition     = contains(["production", "staging"], var.environment)
    error_message = "L'environnement doit être 'production' ou 'staging'."
  }
}

variable "vm_config" {
  description = "Configuration des VMs par environnement"
  type = map(object({
    web_vmid = number
    db_vmid  = number
    web_ip   = string
    db_ip    = string
  }))
  
  default = {
    production = {
      web_vmid = 110
      db_vmid  = 111
      web_ip   = "192.168.1.201"
      db_ip    = "192.168.1.202"
    }
    staging = {
      web_vmid = 120
      db_vmid  = 121
      web_ip   = "192.168.1.211"
      db_ip    = "192.168.1.212"
    }
  }
}
