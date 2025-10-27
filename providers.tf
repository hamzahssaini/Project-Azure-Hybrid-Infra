terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "4.40.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id   =  "6fc13d10-c1bf-4274-8d91-68859a20ab08"
  tenant_id         = "129d979e-2acc-4867-8f4f-950622f47afb"
}