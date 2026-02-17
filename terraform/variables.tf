variable "template_path" {
  description = "Chemin vers le template Debian"
  type        = string
  default     = "D:/VMs/model/Debian_12.0.0_VMM_LinuxVMImages.COM.vmx"
}

variable "vm_base_path" {
  description = "Chemin de base pour les nouvelles VMs"
  type        = string
  default     = "D:/VMs/terraform-vms"
}

variable "vm_web_name" {
  description = "Nom de la VM web"
  type        = string
  default     = "web-server"
}

variable "vm_db_name" {
  description = "Nom de la VM database"
  type        = string
  default     = "db-server"
}

variable "vm_cpu" {
  description = "Nombre de CPUs"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "RAM en MB"
  type        = number
  default     = 2048
}
