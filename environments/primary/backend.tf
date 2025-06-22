terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "tfstateakashdemo"
    container_name       = "tfstate"
    key                  = "primary.terraform.tfstate"
  }
}
