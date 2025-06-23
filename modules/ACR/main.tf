resource "azurerm_container_registry" "this" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard" # Recommended for production
  admin_enabled       = false      # Secure: disable admin user
  public_network_access_enabled = false # Allow only private access (if desired)

  tags = {
    Environment = var.environment
  }
}
