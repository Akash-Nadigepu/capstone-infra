resource "azurerm_traffic_manager_profile" "tm_profile" {
  name                = var.profile_name
  resource_group_name = var.resource_group_name
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
