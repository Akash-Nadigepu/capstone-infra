resource "azurerm_traffic_manager_profile" "tm_profile" {
  name                = var.profile_name
  resource_group_name = var.resource_group_name
  location            = "global"
  traffic_routing_method = "Priority"
  dns_config {
    relative_name = var.dns_name
    ttl           = 30
  }

  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_traffic_manager_endpoint" "primary" {
  name                = "primary-endpoint"
  profile_name        = azurerm_traffic_manager_profile.tm_profile.name
  resource_group_name = var.resource_group_name
  type                = "externalEndpoints"
  target              = var.primary_endpoint
  endpoint_status     = "Enabled"
  priority            = 1
}

resource "azurerm_traffic_manager_endpoint" "secondary" {
  name                = "secondary-endpoint"
  profile_name        = azurerm_traffic_manager_profile.tm_profile.name
  resource_group_name = var.resource_group_name
  type                = "externalEndpoints"
  target              = var.secondary_endpoint
  endpoint_status     = "Enabled"
  priority            = 2
}
