variable "vm_name" {
  description = "Name of the LXD virtual machine"
  type        = string
  default     = "claude-dev"
}

variable "cpus" {
  description = "Number of CPUs allocated to the VM"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Memory allocated to the VM"
  type        = string
  default     = "4GiB"
}

variable "disk_size" {
  description = "Root disk size for the VM"
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
  default     = "/root/vm_projects"
}

variable "ubuntu_image" {
  description = "Ubuntu image to use for the VM"
  type        = string
  default     = "ubuntu:24.04"
}
