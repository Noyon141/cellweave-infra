variable "project_name" {
  description = "Neon Project Name"
  type        = string
  default     = "cellweave"
}

variable "region_id" {
  description = "Neon AWS region identifier"
  type        = string
}

variable "branch_name" {
  description = "Target Neon branch name"
  type        = string
}

variable "history_retention_seconds" {
  description = "Point-in-time recovery (PITR) retention window in seconds"
  type        = number
}

variable "min_cu" {
  description = "Minimum compute units for autoscaling"
  type        = number
}

variable "max_cu" {
  description = "Maximum compute units for autoscaling"
  type        = number
}
