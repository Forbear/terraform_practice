
locals {
  internet_gateway_name = "${var.environment}-internet_gateway"
}

resource "aws_internet_gateway" "perimeter" {
  vpc_id = aws_vpc.perimeter.id
  tags   = merge(var.base_tags, { Name = local.internet_gateway_name })
}
