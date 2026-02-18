resource "proxmox_vm_qemu" "web_server" {
  name        = "web-server"
  target_node = "pve"
  vmid        = 110
  clone       = "debian12-template"
  full_clone  = true
  
  # ACTIVATION DE L'AGENT QEMU
  agent       = 1

  cores   = 2
  sockets = 1
  memory  = 2048

  # Réseau
  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Disque Principal (OS)
  disk {
    slot    = "scsi0"
    storage = "local-lvm"
    type    = "disk"
    size    = "20G"
  }

  # 🚨 DISQUE CLOUD-INIT
  disk {
    slot    = "ide2"
    type    = "cloudinit"
    storage = "local-lvm"
  }

  # Cloud-Init Config
  os_type    = "cloud-init"
  ciuser     = "jordan"
  cipassword = "Serveur1234" 
  ipconfig0  = "ip=192.168.1.201/24,gw=192.168.1.1"
  
  sshkeys = <<EOF
  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHBh2mv22dPFyLNXwFwHgMUamb+3xqmvnNDSUv8xkIG3 jordan@terraform
  EOF
}

resource "proxmox_vm_qemu" "db_server" {
  name        = "db-server"
  target_node = "pve"
  vmid        = 111
  clone       = "debian12-template"
  full_clone  = true
  
  # ACTIVATION DE L'AGENT QEMU
  agent       = 1

  cores   = 2
  sockets = 1
  memory  = 2048

  # Réseau
  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Disque Principal (OS)
  disk {
    slot    = "scsi0"
    storage = "local-lvm"
    type    = "disk"
    size    = "20G"
  }

  # 🚨 DISQUE CLOUD-INIT 
  disk {
    slot    = "ide2"
    type    = "cloudinit"
    storage = "local-lvm"
  }

  # Cloud-Init Config
  os_type    = "cloud-init"
  ciuser     = "jordan"
  cipassword = "Serveur1234"
  ipconfig0  = "ip=192.168.1.202/24,gw=192.168.1.1"
  
  sshkeys = <<EOF
  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHBh2mv22dPFyLNXwFwHgMUamb+3xqmvnNDSUv8xkIG3 jordan@terraform
  EOF
}
