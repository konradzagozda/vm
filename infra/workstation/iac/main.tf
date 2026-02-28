locals {
  tools = { for line in compact(split("\n", file("${path.module}/../tools.env"))) :
    split("=", line)[0] => split("=", line)[1]
  }
}

provider "incus" {}

resource "incus_instance" "vm" {
  name  = var.vm_name
  image = var.ubuntu_image
  type  = "virtual-machine"

  config = {
    "cloud-init.user-data" = templatefile("${path.module}/../cloud-init.yml.tftpl", {
      vm_mount_path    = var.vm_mount_path
      gh_cli_version   = local.tools["GH_CLI_VERSION"]
      gh_token_version = local.tools["GH_TOKEN_VERSION"]
      nodejs_version   = local.tools["NODEJS_VERSION"]
    })
    "limits.cpu"    = var.cpus
    "limits.memory" = var.memory
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

  # Virtual NIC attached to the Incus-managed bridge (incusbr0) for NAT internet access
  device {
    name = "eth0"
    type = "nic"
    properties = {
      name    = "eth0"
      network = "incusbr0"
    }
  }
}
