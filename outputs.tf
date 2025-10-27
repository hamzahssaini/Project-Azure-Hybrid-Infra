output "hub_resource_group" {
  value = module.hub.resource_group_name
}

output "hub_vnet_id" {
  value = module.hub.vnet_id
}

output "hub_subnets" {
  value = {
    gateway  = module.hub.subnet_gateway_id
    bastion  = module.hub.subnet_bastion_id
    firewall = module.hub.subnet_firewall_id
    monitor  = module.hub.subnet_monitor_id
  }
}

output "vpn_gateway_id" {
  value = module.hub.vpn_gateway_id
}

output "firewall_id" {
  value = module.hub.firewall_id
}

output "bastion_id" {
  value = module.hub.bastion_id
}
