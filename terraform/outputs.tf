output "web_server_ip" {
  description = "IP du serveur web (DHCP)"
  value       = proxmox_vm_qemu.web_server.default_ipv4_address
}

output "db_server_ip" {
  description = "IP du serveur DB (statique)"
  value       = "192.168.1.210"
}

output "all_vms" {
  description = "Toutes les VMs créées"
  value = {
    web = proxmox_vm_qemu.web_server.default_ipv4_address
    db  = "192.168.1.210"
  }
}
