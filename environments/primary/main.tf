terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "azurerm_resource_group" "primary" {
  name     = "rg-primary"
  location = "centralindia"
}

module "virtual_network" {
  source              = "../../modules/VirtualNetwork"
  location            = "centralindia"
  resource_group_name = "rg-primary"
  vnet_name           = "primary-vnet"
  address_space       = "10.10.0.0/16"

  aks_subnets = {
    nodepool1 = "10.10.1.0/24"
    nodepool2 = "10.10.2.0/24"
  }

  agw_subnet_prefix = "10.10.3.0/24"
  sql_subnet_prefix = "10.10.4.0/24"
  
  depends_on = [azurerm_resource_group.primary]
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

module "key_vault" {
  source              = "../../modules/KeyVault"
  key_vault_name = "kv-primary-${random_string.suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id
  object_id           = var.object_id
  environment         = "dev" 
}
module "aks" {
  source              = "../../modules/AKS"
  aks_name            = "aks-primary"
  resource_group_name = azurerm_resource_group.primary.name
  location            = azurerm_resource_group.primary.location
  dns_prefix          = "aksprimary"
  node_count          = 2
  vm_size             = "Standard_B2ms"
  subnet_id           = module.virtual_network.aks_subnet_ids["nodepool1"]
  environment         = "dev"

  depends_on = [module.virtual_network]
}
