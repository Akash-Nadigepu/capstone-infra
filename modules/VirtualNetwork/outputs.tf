output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "aks_subnet_ids" {
  value = { for k, subnet in azurerm_subnet.aks : k => subnet.id }
}

output "agw_subnet_id" {
  value = azurerm_subnet.agw.id
}

output "sql_subnet_id" {
  value = azurerm_subnet.sql.id
}
