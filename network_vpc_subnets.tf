
data "aws_availability_zones" "terraform" {
  state = "available"
}

locals {
  sliced_cidrs = slice(var.subnets_map["base_c"], 0, length(data.aws_availability_zones.terraform.names))
}

resource "aws_subnet" "perimeter" {
  for_each          = zipmap(data.aws_availability_zones.terraform.names, local.sliced_cidrs)
  availability_zone = each.key
  cidr_block        = each.value
  vpc_id            = aws_vpc.internet_facing.id
  tags              = merge(var.base_tags, { Name = "${var.environment}-subnet-${each.key}" })
}
