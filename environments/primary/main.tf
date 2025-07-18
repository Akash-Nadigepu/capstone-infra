terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.98"
    }
  }
  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  skip_provider_registration = true
}


resource "azurerm_resource_group" "primary" {
  name     = "rg-primary"
  location = "polandcentral"
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

module "virtual_network" {
  source              = "../../modules/VirtualNetwork"
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name
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

module "acr" {
  source              = "../../modules/ACR"
  acr_name            = "acrprimary1${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.primary.name
  location            = azurerm_resource_group.primary.location
  sku                 = "Basic"
  admin_enabled       = false
  environment         = "prod"

  depends_on = [azurerm_resource_group.primary]
}
resource "time_sleep" "wait_after_acr" {
  depends_on = [module.acr]
  create_duration = "30s"
}

module "key_vault" {
  source              = "../../modules/KeyVault"
  key_vault_name      = "kv-primary-1${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.primary.name
  location            = azurerm_resource_group.primary.location
  tenant_id           = var.tenant_id
  object_id           = var.object_id
  environment         = "prod"

  depends_on = [azurerm_resource_group.primary]
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
  environment         = "prod"
  acr_name            = module.acr.acr_name

  depends_on = [
    module.virtual_network,
    module.acr,                        # Ensures ACR is created
    azurerm_resource_group.primary
  ]
}
module "traffic_manager" {
  source              = "../../modules/TrafficManager"
  profile_name        = "tm-primary"
  dns_name            = "mytm-akash"
  resource_group_name = azurerm_resource_group.primary.name
  primary_endpoint    = "1.2.3.4"   # Replace later with actual IP or FQDN
  secondary_endpoint  = "5.6.7.8"   # Replace later
  environment         = "prod"
  depends_on          = [azurerm_resource_group.primary]
}
data "azurerm_key_vault" "kv" {
  name                = "kv-primary-13mih"
  resource_group_name = "rg-primary"
}

data "azurerm_key_vault_secret" "sql_password" {
  name         = "akash"
  key_vault_id = data.azurerm_key_vault.kv.id
}

module "sql_db" {
  source                = "../../modules/SQLDatabase"
  sql_server_name       = "sqlserver${random_string.suffix.result}"
  sql_database_name     = "userdb"
  resource_group_name   = azurerm_resource_group.primary.name
  location              = azurerm_resource_group.primary.location
  sql_admin_username    = "akash"
  sql_admin_password    = data.azurerm_key_vault_secret.sql_password.value
  environment           = "prod"

  depends_on = [module.key_vault]
}


