output "web_server_info" {
  description = "Informations du serveur web"
  value = {
    id   = vmworkstation_vm.web_server.id
    name = vmworkstation_vm.web_server.denomination
    path = vmworkstation_vm.web_server.path
  }
}

output "db_server_info" {
  description = "Informations du serveur de base de données"
  value = {
    id   = vmworkstation_vm.db_server.id
    name = vmworkstation_vm.db_server.denomination
    path = vmworkstation_vm.db_server.path
  }
}

output "deployment_summary" {
  description = "Résumé du déploiement"
  value = {
    web_server = var.vm_web_name
    db_server  = var.vm_db_name
    network    = "NAT - Réseau commun"
    status     = "Déployé avec Terraform"
  }
}
