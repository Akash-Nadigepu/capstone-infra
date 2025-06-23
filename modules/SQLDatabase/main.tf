resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  minimum_tls_version          = "1.2"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_mssql_database" "sql_db" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_id           = azurerm_mssql_server.sql_server.id
  sku_name            = var.sku_name

  tags = {
    environment = var.environment
  }

  depends_on = [azurerm_mssql_server.sql_server]
}
