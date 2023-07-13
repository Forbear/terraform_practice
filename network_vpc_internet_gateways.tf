
locals {
  internet_gateway_name = "${var.environment}-${var.purpose}-VPC-internet_gateway"
}

resource "aws_internet_gateway" "by_terraform" {
  vpc_id = aws_vpc.by_terraform.id
  tags   = merge(var.base_tags, { Name = local.internet_gateway_name })
}
