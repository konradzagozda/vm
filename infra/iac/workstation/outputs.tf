output "vm_name" {
  description = "Name of the provisioned VM"
  value       = incus_instance.vm.name
}

output "vm_ipv4" {
  description = "IPv4 address of the VM"
  value       = incus_instance.vm.ipv4_address
}
