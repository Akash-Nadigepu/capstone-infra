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
