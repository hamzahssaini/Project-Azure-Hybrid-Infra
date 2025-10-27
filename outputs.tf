# ✅ Hub Resource Group Name
output "hub_resource_group" {
  value = module.hub.rg_name
}

# ✅ Hub VNet ID
output "hub_vnet_id" {
  value = module.hub.vnet_id
}

# ✅ Hub Subnets IDs
output "hub_subnets" {
  value = {
    gateway  = module.hub.subnet_gateway_id
    bastion  = module.hub.subnet_bastion_id
    firewall = module.hub.subnet_firewall_id
    monitor  = module.hub.subnet_monitor_id
  }
}

# ✅ VPN Gateway ID
output "vpn_gateway_id" {
  value = module.hub.vpn_gateway_id
}

# ✅ Firewall ID
output "firewall_id" {
  value = module.hub.firewall_id
}

# ✅ Bastion ID
output "bastion_id" {
  value = module.hub.bastion_id
}
