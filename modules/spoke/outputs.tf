output "rg_name" {
  value = azurerm_resource_group.spoke.name
}

output "vnet_id" {
  value = azurerm_virtual_network.spoke.id
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "vm_private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "vnet_name" {
  value = azurerm_virtual_network.spoke.name
}
