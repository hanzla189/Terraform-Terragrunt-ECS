variable "aws_region" {
  description = "AWS region for Terraform backend resources."
  type        = string
  default     = "eu-west-1"
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform remote state."
  type        = string
  default     = "vouch-terraform-state"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.state_bucket_name))
    error_message = "S3 bucket name must be lowercase, globally unique, and valid."
  }
}

variable "lock_table_name" {
  description = "DynamoDB table name for Terraform state locking."
  type        = string
  default     = "vouch-terraform-locks"
}

variable "force_destroy" {
  description = "Allow Terraform to destroy the state bucket even if it contains objects. Keep false for client environments."
  type        = bool
  default     = false
}

variable "default_tags" {
  description = "Default tags for backend resources."
  type        = map(string)
  default = {
    Project     = "vouch"
    Environment = "shared"
    ManagedBy   = "terraform"
    Owner       = "devops"
  }
}
