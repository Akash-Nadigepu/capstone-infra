variable "sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Whether admin user is enabled on the ACR"
  type        = bool
  default     = false
}

variable "acr_name" {
  type        = string
  description = "The name of the Azure Container Registry."
}

variable "location" {
  type        = string
  description = "The Azure location for the ACR."
}

variable "resource_group_name" {
  type        = string
  description = "The resource group where the ACR will be created."
}

variable "environment" {
  type        = string
  description = "Environment tag for this deployment (e.g., dev, prod)."
}
