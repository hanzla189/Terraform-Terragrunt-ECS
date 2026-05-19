variable "project" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Exactly 3 availability zones for Day 2 foundation."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 3
    error_message = "Day 2 requires exactly 3 Availability Zones."
  }
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == 3
    error_message = "Day 2 requires exactly 3 public subnets."
  }
}

variable "private_subnet_cidrs" {
  description = "Private application subnet CIDRs."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == 3
    error_message = "Day 2 requires exactly 3 private application subnets."
  }
}

variable "database_subnet_cidrs" {
  description = "Database subnet CIDRs."
  type        = list(string)

  validation {
    condition     = length(var.database_subnet_cidrs) == 3
    error_message = "Day 2 requires exactly 3 database subnets."
  }
}

variable "enable_nat_gateway" {
  description = "Create NAT Gateway for private subnet outbound access."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use one NAT Gateway for cost control. Set false for one NAT per AZ."
  type        = bool
  default     = true
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs to CloudWatch Logs."
  type        = bool
  default     = true
}

variable "flow_log_retention_days" {
  description = "CloudWatch Logs retention for VPC Flow Logs."
  type        = number
  default     = 30
}

variable "management_ingress_cidrs" {
  description = "Optional CIDRs allowed to management SG. Keep empty until approved."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags."
  type        = map(string)
  default     = {}
}
