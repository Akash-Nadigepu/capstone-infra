provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.3.0"
}

module "tf_backend" {
  source               = "../../modules/terraform-backend"
  resource_group_name  = "rg-terraform-backend"
  location             = "centralindia"
  storage_account_name = "tfstateakashdemo"     
  container_name       = "tfstate"
}
