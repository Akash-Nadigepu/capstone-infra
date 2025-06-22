# modules/KeyVault/main.tf
resource "azurerm_key_vault" "this" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  public_network_access_enabled = false

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id # This should be your SP/App ID or User
    secret_permissions = ["Get", "List", "Set", "Delete"]
  }

  tags = {
    environment = var.environment
  }
}
