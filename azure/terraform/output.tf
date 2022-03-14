output "nfs_ip" {
  value = azurerm_linux_virtual_machine.vm_nfs.public_ip_address
}

output "master_ip" {
  value = azurerm_linux_virtual_machine.vm_master.public_ip_address
}

output "workers_ips" {
  value = azurerm_linux_virtual_machine.vm_workes.*.public_ip_address
}

