
variable "config_version" {
  description = "Configuration version to track. Can be found in resource tags."
  type        = number
}

variable "environment" {
  description = "Environment definition used as prefix in resource name."
  type        = string
}

variable "internet_facing" {
  description = "Defines if internet gateway will be created."
  type        = bool
}

variable "manager" {
  description = "Hints about who did this to infrastructure."
  type        = string
}

variable "subnets" {
  description = "List of subnets to create."
  type        = list(string)
}

variable "vpc_cidr" {
  description = "VPC cidr to use."
  type        = string
}
