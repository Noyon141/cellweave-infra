variable "project_name" {
  description = "Neon Project Name"
  type        = string
  default     = "cellweave"
}

variable "region_id" {
  description = "Neon AWS region identifier"
  type        = string
  default     = "aws-us-east-2"
}

variable "branch_name" {
  description = "Target Neon branch name"
  type        = string
}

variable "history_retention_seconds" {
  description = "Point-in-time recovery (PITR) retention window in seconds (default: 86400 = 1 day)"
  type        = number
  default     = 86400
}

variable "min_cu" {
  description = "Minimum compute units for autoscaling"
  type        = number
  default     = 0.25
}

variable "max_cu" {
  description = "Maximum compute units for autoscaling"
  type        = number
  default     = 2.0
}
