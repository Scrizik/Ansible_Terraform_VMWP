# VM Web Server Debian 12
resource "proxmox_vm_qemu" "web_server" {
  name        = "debian-web-01"
  target_node = "pve"
  clone       = "debian-12-standard"

  cores   = 2
  sockets = 1
  memory  = 2048

  disk {
    type    = "scsi"
    storage = "local-lvm"
    size    = "20G"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=dhcp"

  os_type = "cloud-init"

  lifecycle {
    ignore_changes = [network, cipassword]
  }
}

# VM DB Server Debian 12
resource "proxmox_vm_qemu" "db_server" {
  name        = "debian-db-01"
  target_node = "pve"
  clone       = "debian-12-standard"

  cores   = 4
  sockets = 1
  memory  = 4096

  disk {
    type    = "scsi"
    storage = "local-lvm"
    size    = "30G"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=192.168.1.210/24,gw=192.168.1.1"

  os_type = "cloud-init"

  lifecycle {
    ignore_changes = [network, cipassword]
  }
}
