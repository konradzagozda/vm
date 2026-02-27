output "vm_name" {
  description = "Name of the provisioned VM"
  value       = lxd_instance.claude_dev.name
}

output "vm_ipv4" {
  description = "IPv4 address of the VM"
  value       = lxd_instance.claude_dev.ipv4_address
}
