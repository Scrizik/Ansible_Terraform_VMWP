# VM Web Server
resource "vmworkstation_vm" "web_server" {
  sourceid     = var.template_path
  denomination = var.vm_web_name
  description  = "Serveur Web Nginx - TP Niveau 1"
  path         = "${var.vm_base_path}/${var.vm_web_name}"
  
  processors = var.vm_cpu
  memory     = var.vm_memory
  
  network_adapter {
    adapter_number = 0
    adapter_type   = "e1000e"
    network_type   = "nat"
  }
  
  guest_os = "debian11-64"
}

# VM Database Server
resource "vmworkstation_vm" "db_server" {
  sourceid     = var.template_path
  denomination = var.vm_db_name
  description  = "Serveur de base de donnees MariaDB - TP Niveau 1"
  path         = "${var.vm_base_path}/${var.vm_db_name}"
  
  processors = var.vm_cpu
  memory     = var.vm_memory
  
  network_adapter {
    adapter_number = 0
    adapter_type   = "e1000e"
    network_type   = "nat"
  }
  
  guest_os = "debian11-64"
}
