variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "address_space" {
  type        = string
  description = "CIDR block for the virtual network"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name where the VNet will be created"
}

variable "location" {
  type        = string
  description = "Azure region for the VNet"
}

variable "aks_subnets" {
  type = map(string)
  description = "Map of AKS nodepool names to their subnet CIDR blocks"
}

variable "agw_subnet_prefix" {
  type        = string
  description = "CIDR for Application Gateway subnet"
}

variable "sql_subnet_prefix" {
  type        = string
  description = "CIDR for SQL subnet"
}
