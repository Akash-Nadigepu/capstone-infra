variable "tenant_id" {
  type        = string
  description = "Tenant ID for Azure AD"
}

variable "object_id" {
  type        = string
  description = "Object ID for the principal accessing Key Vault"
}
