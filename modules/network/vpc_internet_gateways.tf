
locals {
  internet_gateway_name = "${var.environment}-internet_gateway"
}

resource "aws_internet_gateway" "primary" {
  count  = var.internet_facing ? 1 : 0
  vpc_id = aws_vpc.primary.id
  tags = merge({
    managed_by = "${var.manager}",
    version    = "${var.config_version}",
    Name       = local.internet_gateway_name,
  })
}
