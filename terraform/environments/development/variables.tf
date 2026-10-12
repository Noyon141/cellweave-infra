variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Development (operator-configured)"
  type        = string
}

variable "neon_region_id" {
  description = "Neon region ID (operator-configured)"
  type        = string
}

variable "neon_min_cu" {
  description = "Neon minimum compute units for autoscaling (operator-configured)"
  type        = number
}

variable "neon_max_cu" {
  description = "Neon maximum compute units for autoscaling (operator-configured)"
  type        = number
}

variable "neon_history_retention_seconds" {
  description = "Neon Point-in-time recovery (PITR) retention window in seconds (operator-configured)"
  type        = number
}

variable "temporal_retention_days" {
  description = "Temporal workflow execution history retention period in days (operator-configured)"
  type        = number
}
