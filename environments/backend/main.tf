provider "azurerm" {
  features {}
}

module "tf_backend" {
  source               = "../../modules/terraform-backend"
  resource_group_name  = "rg-terraform-backend"
  location             = "centralindia"
  storage_account_name = "tfstateakashdemo"     
  container_name       = "tfstate"
}
