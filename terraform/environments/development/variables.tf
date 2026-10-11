variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Development"
  type        = string
}

variable "neon_region_id" {
  description = "Neon region ID"
  type        = string
  default     = "aws-us-east-2"
}

variable "neon_history_retention_seconds" {
  description = "Neon Point-in-time recovery (PITR) retention window in seconds (operator-configured)"
  type        = number
  default     = 86400
}

variable "neon_min_cu" {
  description = "Neon minimum compute units for autoscaling (operator-configured)"
  type        = number
  default     = 0.25
}

variable "neon_max_cu" {
  description = "Neon maximum compute units for autoscaling (operator-configured)"
  type        = number
  default     = 1.0
}

variable "temporal_retention_days" {
  description = "Temporal workflow execution history retention period in days (operator-configured)"
  type        = number
  default     = 7
}
