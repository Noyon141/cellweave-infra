variable "account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "bucket_name" {
  description = "The name of the R2 bucket (must be strictly private)"
  type        = string
}

variable "location" {
  description = "Geographic location hint for R2 bucket"
  type        = string
  default     = "wnam" # Western North America (or enam for Eastern North America)
}

variable "environment" {
  description = "Deployment environment name (development, staging, production, preview)"
  type        = string
}
