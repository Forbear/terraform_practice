
locals {
  vpc_name = "${var.environment}-VPC"
}

resource "aws_vpc" "perimeter" {
  cidr_block = var.vpc_cidr
  tags       = merge(var.base_tags, { Name = local.vpc_name })
}

/*
    I tried create vpcs using for_each.
    There is a problem during subnets creation in that case;
    as vpc refer should contain each.key.
*/

/*
resource "aws_vpc" "NAME" {
  for_each   = toset(var.vpc_cidr_list)
  cidr_block = each.key
  tags       = merge(var.base_tags, { Name = local.vpc_name })
}
*/

/*
    THere is no ipam free tier :)
*/

/*
resource "aws_vpc_ipam" "terraform" {
  operating_regions {
    region_name = data.aws_region.current.name
  }
}

resource "aws_vpc_ipam_pool" "terraform" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.terraform.private_default_scope_id
  locale         = data.aws_region.current.name
}

resource "aws_vpc_ipam_pool_cidr" "terraform" {
  ipam_pool_id = aws_vpc_ipam_pool.terraform.id
  cidr         = "10.0.0.0/24"
}

resource "aws_vpc" "terraform" {
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.terraform.id
  ipv4_netmask_length = 24
  depends_on          = [aws_vpc_ipam_pool_cidr.terraform, ]
  tags = {
    Name       = "terraform_vpc"
    managed_by = "terraform"
  }
}
*/
