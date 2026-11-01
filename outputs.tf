output "resource_group" {
  value = azurerm_resource_group.lab.name
}

output "vnet_id" {
  value = azurerm_virtual_network.lab.id
}

output "public_ip" {
  value = azurerm_public_ip.vm.ip_address
}

output "ssh_command" {
  value = "ssh jason@${azurerm_public_ip.vm.ip_address}"
}
