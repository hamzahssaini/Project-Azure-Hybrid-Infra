output "rg_name" {
  description = "The name of the Hub resource group"
  value       = azurerm_resource_group.hub.name
}

output "vnet_name" {
  description = "The name of the Hub virtual network"
  value       = azurerm_virtual_network.hub.name
}

output "vnet_id" {
  description = "The ID of the Hub virtual network"
  value       = azurerm_virtual_network.hub.id
}

output "location" {
  description = "Hub network location"
  value       = azurerm_resource_group.hub.location
}

output "subnet_gateway_id" {
  value = azurerm_subnet.gateway.id
}

output "subnet_bastion_id" {
  value = azurerm_subnet.bastion.id
}

output "subnet_firewall_id" {
  value = azurerm_subnet.firewall.id
}

output "subnet_monitor_id" {
  value = azurerm_subnet.monitor.id
}

output "vpn_gateway_id" {
  value = azurerm_virtual_network_gateway.vpn_gw.id
}

output "firewall_id" {
  value = azurerm_firewall.fw.id
}

output "bastion_id" {
  value = azurerm_bastion_host.bastion.id
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.la.id
}
