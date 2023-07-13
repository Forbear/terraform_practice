
locals {
  internet_gateway_name = "${var.environment}-${var.purpose}-VPC-internet_gateway"
}

resource "aws_internet_gateway" "perimeter" {
  vpc_id = aws_vpc.internet_facing.id
  tags   = merge(var.base_tags, { Name = local.internet_gateway_name })
}
