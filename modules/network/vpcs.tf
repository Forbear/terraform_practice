
locals {
  vpc_name = "${var.environment}-VPC"
}

resource "aws_vpc" "primary" {
  cidr_block = var.vpc_cidr
  tags = merge({
    managed_by = "${var.manager}",
    version    = "${var.config_version}",
    Name       = local.vpc_name,
  })
}
