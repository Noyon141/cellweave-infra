# Temporal Cloud Namespace Configuration Module
# Manages namespace parameters and retention policy

variable "namespace_name" {
  description = "Name of the Temporal namespace"
  type        = string
}

variable "retention_days" {
  description = "Workflow execution history retention period in days"
  type        = number
  default     = 7
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

output "namespace_name" {
  description = "The registered Temporal namespace name"
  value       = var.namespace_name
}

output "retention_days" {
  description = "Configured workflow retention period in days"
  value       = var.retention_days
}
