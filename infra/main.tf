provider "lxd" {}

resource "lxd_instance" "claude_dev" {
  name  = var.vm_name
  image = var.ubuntu_image
  type  = "virtual-machine"

  config = {
    "cloud-init.user-data" = templatefile("${path.module}/cloud-init.yml.tftpl", {
      vm_mount_path = var.vm_mount_path
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
    name = "eth0"
    type = "nic"
    properties = {
      name    = "eth0"
      network = "lxdbr0"
    }
  }
}
