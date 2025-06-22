provider "azurerm" {
  features = {}
}

module "virtual_network" {
  source              = "../../modules/VirtualNetwork"
  location            = "India Central"
  resource_group_name = "rg-primary"
  vnet_name           = "primary-vnet"
  address_space       = "10.10.0.0/16"

  aks_subnets = {
    nodepool1 = "10.10.1.0/24"
    nodepool2 = "10.10.2.0/24"
  }

  agw_subnet_prefix = "10.10.3.0/24"
  sql_subnet_prefix = "10.10.4.0/24"
}
