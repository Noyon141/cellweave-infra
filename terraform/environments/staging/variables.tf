variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Staging"
  type        = string
}

variable "neon_region_id" {
  description = "Neon region ID"
  type        = string
  default     = "aws-us-east-2"
}
