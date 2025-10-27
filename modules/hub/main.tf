locals {
  name_rg  = "${var.prefix}-rg-hub"
  vnet_name = "${var.prefix}-hub-vnet"
  tags = merge(var.tags, { created_by = "terraform", component = "hub" })
}

# Resource Group
resource "azurerm_resource_group" "hub" {
  name     = local.name_rg
  location = var.location
  tags     = local.tags
}

# Virtual Network
resource "azurerm_virtual_network" "hub" {
  name                = local.vnet_name
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = var.hub_address_space
  tags                = local.tags
}

# Subnets required by Azure components
resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet" # required name
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.gateway_subnet_prefix]
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet" # required name
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.bastion_subnet_prefix]
}

resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet" # required name
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.firewall_subnet_prefix]
}

resource "azurerm_subnet" "monitor" {
  name                 = "monitor-subnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.monitor_subnet_prefix]
}

# Log Analytics (for Monitor / Firewall logging)
resource "azurerm_log_analytics_workspace" "la" {
  name                = "${var.prefix}-law"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.tags
}

# Network Watcher (one per region in a RG)
resource "azurerm_network_watcher" "nw" {
  name                = "${var.prefix}-nw"
  location            = var.location
  resource_group_name = azurerm_resource_group.hub.name
  tags                = local.tags
}

# Public IP for VPN Gateway
resource "azurerm_public_ip" "vpn_pip" {
  name                = "${var.prefix}-vpn-pip"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

# Virtual Network Gateway (VPN)
resource "azurerm_virtual_network_gateway" "vpn_gw" {
  name                = "${var.prefix}-vpngw"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1"

  ip_configuration {
    name                 = "vpngw-ipcfg"
    public_ip_address_id = azurerm_public_ip.vpn_pip.id
    subnet_id            = azurerm_subnet.gateway.id
  }

  tags = local.tags
}

# Public IP for Firewall
resource "azurerm_public_ip" "fw_pip" {
  name                = "${var.prefix}-fw-pip"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

# Azure Firewall
resource "azurerm_firewall" "fw" {
  name                = "${var.prefix}-firewall"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "fw-config"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }

  tags = local.tags
}

# Public IP for Bastion
resource "azurerm_public_ip" "bastion_pip" {
  name                = "${var.prefix}-bastion-pip"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

# Azure Bastion Host
resource "azurerm_bastion_host" "bastion" {
  name                = "${var.prefix}-bastion"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name

  ip_configuration {
    name                 = "bastion-ip"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }

  tags = local.tags
}
