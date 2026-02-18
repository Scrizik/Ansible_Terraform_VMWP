output "environment" {
  description = "Environnement déployé"
  value       = var.environment
}

output "web_server_ip" {
  description = "IP du serveur web"
  value       = var.vm_config[var.environment].web_ip
}

output "db_server_ip" {
  description = "IP du serveur DB"
  value       = var.vm_config[var.environment].db_ip
}

output "all_vms" {
  description = "Toutes les VMs créées"
  value = {
    environment = var.environment
    web = {
      name = "web-server-${var.environment}"
      vmid = var.vm_config[var.environment].web_vmid
      ip   = var.vm_config[var.environment].web_ip
    }
    db = {
      name = "db-server-${var.environment}"
      vmid = var.vm_config[var.environment].db_vmid
      ip   = var.vm_config[var.environment].db_ip
    }
  }
}

output "ansible_inventory_snippet" {
  description = "Snippet pour l'inventory Ansible"
  value = <<-EOT
  ---
  all:
    children:
      ${var.environment}:
        children:
          web:
            hosts:
              web-server-${var.environment}:
                ansible_host: ${var.vm_config[var.environment].web_ip}
                ansible_user: jordan
          db:
            hosts:
              db-server-${var.environment}:
                ansible_host: ${var.vm_config[var.environment].db_ip}
                ansible_user: jordan
  EOT
}
