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
      incus_version    = local.tools["INCUS_VERSION"]
      opentofu_version = local.tools["OPENTOFU_VERSION"]
      gh_cli_version   = local.tools["GH_CLI_VERSION"]
      gh_token_version = local.tools["GH_TOKEN_VERSION"]
    })
    "limits.cpu"       = var.cpus
    "limits.memory"    = var.memory
    "security.nesting" = "true"
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
