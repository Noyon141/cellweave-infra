variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Production"
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
  default     = 604800
}

variable "temporal_retention_days" {
  description = "Temporal workflow execution history retention period in days (operator-configured)"
  type        = number
  default     = 7
}
