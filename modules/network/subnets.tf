
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  sliced_cidrs = slice(var.subnets, 0, length(data.aws_availability_zones.available.names))
}

resource "aws_subnet" "primary" {
  for_each          = zipmap(data.aws_availability_zones.available.names, local.sliced_cidrs)
  availability_zone = each.key
  cidr_block        = each.value
  vpc_id            = aws_vpc.primary.id
  tags = merge({
    managed_by = "${var.manager}",
    version    = "${var.config_version}",
    Name       = "${var.environment}-subnet-${each.key}",
  })
}
