output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
output "nodepool1_subnet_id" {
  value = azurerm_subnet.nodepool1.id
}

output "nodepool2_subnet_id" {
  value = azurerm_subnet.nodepool2.id
}
