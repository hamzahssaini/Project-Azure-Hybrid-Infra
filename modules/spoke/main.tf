locals {
  rg_name   = "${var.prefix}-rg"
  vnet_name = "${var.prefix}-vnet"
  tags      = merge(var.tags, { created_by = "terraform", component = "spoke" })
}

# Resource Group
resource "azurerm_resource_group" "spoke" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}

# Virtual Network
resource "azurerm_virtual_network" "spoke" {
  name                = local.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.spoke.name
  tags                = local.tags
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.subnet_prefix]
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.spoke.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = local.tags
}

# Windows VM
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "${var.prefix}-vm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.spoke.name
  size                  = var.vm_size
  admin_username        = var.vm_admin_username
  admin_password        = var.vm_admin_password
  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  tags = local.tags
}

# Peering with Hub
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "${var.prefix}-to-hub"
  resource_group_name       = azurerm_resource_group.spoke.name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = var.hub_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "hub-to-${var.prefix}"
  resource_group_name       = var.hub_rg_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

