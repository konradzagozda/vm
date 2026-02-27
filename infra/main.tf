provider "lxd" {}

resource "lxd_instance" "vm" {
  name  = var.vm_name
  image = var.ubuntu_image
  type  = "virtual-machine"

  config = {
    "cloud-init.user-data" = templatefile("${path.module}/cloud-init.yml.tftpl", {
      vm_mount_path = var.vm_mount_path
      vm_packages   = file("${path.module}/scripts/vm-packages.txt")
      vm_setup_sh   = file("${path.module}/scripts/vm-setup.sh")
    })
  }

  limits = {
    cpu    = var.cpus
    memory = var.memory
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      pool = "default"
      path = "/"
      size = var.disk_size
    }
  }

  device {
    name = "workspace"
    type = "disk"
    properties = {
      source = var.host_mount_path
      path   = var.vm_mount_path
    }
  }

  device {
    name = "secrets"
    type = "disk"
    properties = {
      source = var.host_secrets_path
      path   = "/root/secrets"
    }
  }

  # Attaches a virtual NIC to the VM via the LXD-managed bridge.
  # lxdbr0 is the default bridge created by `lxd init`, providing
  # NAT-based internet access and DHCP for the VM.
  device {
    name = "eth0"
    type = "nic"
    properties = {
      name    = "eth0"    # Interface name inside the VM
      network = "lxdbr0"  # LXD-managed bridge on the host
    }
  }
}
