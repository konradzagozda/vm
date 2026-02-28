variable "vm_name" {
  description = "Name of the Incus virtual machine"
  type        = string
  default     = "workstation"
}

variable "cpus" {
  description = "Number of CPUs for the VM (2 is minimum for comfortable builds)"
  type        = number
  default     = 2
}

variable "memory" {
  description = "VM memory (4GiB is minimum for Claude Code + build tools)"
  type        = string
  default     = "4GiB"
}

variable "disk_size" {
  description = "Root disk size (20GiB covers OS + packages + workspace)"
  type        = string
  default     = "20GiB"
}

variable "host_mount_path" {
  description = "Absolute path on the host to mount into the VM"
  type        = string
}

variable "vm_mount_path" {
  description = "Path inside the VM where the host directory is mounted"
  type        = string
  default     = "/root/projects"
}

variable "ubuntu_image" {
  description = "Ubuntu image to use for the VM"
  type        = string
  default     = "images:ubuntu/24.04/cloud"
}

variable "host_secrets_path" {
  description = "Absolute path to the secrets directory on the bare_metal (contains .env, private keys)"
  type        = string
}
