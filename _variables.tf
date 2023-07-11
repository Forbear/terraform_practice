
variable "aws_region" {
  description = "AWS region for resources to be provision."
  type        = string # types are string, number, bool, list(any)
  default     = "eu-central-1"
}

variable "free_tier_instance_type" {
  description = "AWS instance type that's free in selected region."
  type        = string
  default     = "t2.micro"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "DEV"
}

variable "purpose" {
  description = "For what is it all?"
  type        = string
  default     = "automation"
}

variable "base_tags" {
  description = "Default tags for resources"
  type        = map(any)
  default = {
    managed_by = "terraform"
    version    = "0.1"
  }
}
