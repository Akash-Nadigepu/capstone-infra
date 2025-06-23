variable "tenant_id" {
  description = "The tenant ID for the Key Vault access policy"
  type        = string
}

variable "object_id" {
  description = "The object ID of the principal to grant access to Key Vault"
  type        = string
}

variable "location" {
  description = "Azure location for resources"
  type        = string
  default     = "japaneast"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-primary"
}
