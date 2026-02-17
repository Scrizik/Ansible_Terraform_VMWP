output "web_server_ip" {
  description = "IP du serveur web (statique)"
  value       = "192.168.1.201"
}

output "db_server_ip" {
  description = "IP du serveur DB (statique)"
  value       = "192.168.1.202"
}

output "all_vms" {
  description = "Toutes les VMs créées"
  value = {
    web = "192.168.1.201"
    db  = "192.168.1.202"
  }
}
