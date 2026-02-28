variable "vm_name" {
  description = "Name of the e2e test runner VM"
  type        = string
  default     = "e2e_test_runner"
}

variable "cpus" {
  description = "Number of CPUs for the VM"
  type        = number
  default     = 2
}

variable "memory" {
  description = "VM memory"
  type        = string
  default     = "4GiB"
}

variable "disk_size" {
  description = "Root disk size"
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
