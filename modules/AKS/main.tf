resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "nodepool1"
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true

  network_profile {
    network_plugin    = "azure"
    dns_service_ip    = "10.2.0.10"
    service_cidr      = "10.2.0.0/16"
    docker_bridge_cidr = "172.17.0.1/16"
  }
  web_app_routing {
  }
  tags = {
    Environment = var.environment
  }
}
