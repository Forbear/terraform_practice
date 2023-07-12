
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
    version    = 0.1
  }
}

variable "vpc_cidr" {
  description = "Predefined vpc cidr."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets_map" {
  description = "Predefined list of subnets."
  type        = map(any)
  default = {
    base_c = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", ]
  }
}
