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
  location           = "westus"
  address_space      = ["10.1.0.0/16"]
  subnet_name        = "subnet-app"
  subnet_prefix      = "10.1.1.0/24"
  vm_admin_password  = "Hamza@987987"
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
  location           = "westus"
  address_space      = ["10.2.0.0/16"]
  subnet_name        = "subnet-db"
  subnet_prefix      = "10.2.1.0/24"
  vm_admin_password  = "Hamza@987987"
  hub_vnet_id        = module.hub.vnet_id
  hub_vnet_name      = module.hub.vnet_name
  hub_rg_name        = module.hub.rg_name
  tags = {
    project = "Hybrid-Azure"
    owner   = "Hamza"
  }
}
