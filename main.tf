module "hub" {
  source   = "./modules/hub"
  prefix   = var.prefix
  location = var.location
  tags     = var.tags
}
# ✅ Spoke 1: Application
module "spoke_app" {
  source             = "./modules/spoke"
  prefix             = "spoke-app"
  location           = "France Central"
  address_space      = ["10.1.1.0/16"]
  subnet_name        = "subnet-app"
  subnet_prefix      = "10.1.1.0/24"
  vm_admin_password  = "P@ssword123!"
  hub_vnet_id        = module.hub.vnet_id
  hub_vnet_name      = module.hub.vnet_name
  hub_rg_name        = module.hub.rg_name
  tags = {
    project = "Hybrid-Azure"
    owner   = "Hamza"
  }
}

# ✅ Spoke 2: Database
module "spoke_db" {
  source             = "./modules/spoke"
  prefix             = "spoke-db"
  location           = "France Central"
  address_space      = ["10.2.1.0/16"]
  subnet_name        = "subnet-db"
  subnet_prefix      = "10.2.1.0/24"
  vm_admin_password  = "P@ssword123!"
  hub_vnet_id        = module.hub.vnet_id
  hub_vnet_name      = module.hub.vnet_name
  hub_rg_name        = module.hub.rg_name
  tags = {
    project = "Hybrid-Azure"
    owner   = "Hamza"
  }
}
# ✅ Private Endpoint (App → DB)
resource "azurerm_private_endpoint" "app_to_db" {
  name                = "pe-app-to-db"
  location            = "East US"
  resource_group_name = module.spoke_app.rg_name
  subnet_id           = module.spoke_app.subnet_id

  private_service_connection {
    name                           = "psc-db"
    private_connection_resource_id = module.spoke_db.vnet_id
    subresource_names              = ["networkInterfaces"]
    is_manual_connection           = false
  }
}