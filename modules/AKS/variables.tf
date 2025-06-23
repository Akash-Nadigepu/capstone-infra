variable "aks_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "dns_prefix" {}
variable "node_count" {
  default = 2
}
variable "vm_size" {
  default = "Standard_DS2_v2"
}
variable "subnet_id" {}
variable "environment" {}
variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = null
}
