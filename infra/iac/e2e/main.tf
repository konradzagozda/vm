provider "incus" {}

resource "incus_instance" "vm" {
  name  = var.vm_name
  image = var.ubuntu_image
  type  = "virtual-machine"

  config = {
    "cloud-init.user-data" = file("${path.module}/../../e2e_test_runner.cloud_init.yml")
    "limits.cpu"           = var.cpus
    "limits.memory"        = var.memory
    "security.nesting"     = "true"
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
      network = "incusbr0"
    }
  }
}
