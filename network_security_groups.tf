
locals {
  www_sg_name = "${var.environment}-${var.purpose}-www-open-sg"
}

resource "aws_security_group" "by_terraform_www_open" {
  name        = "www_open_sg"
  description = "SG to open world wide web access to resources/apps."
  vpc_id      = aws_vpc.by_terraform.id
  tags        = merge(var.base_tags, { Name = local.www_sg_name })
}

resource "aws_vpc_security_group_ingress_rule" "from_terraform_vpc" {
  for_each          = toset(["80", "443"])
  security_group_id = aws_security_group.by_terraform_www_open.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  to_port           = each.key
  ip_protocol       = "tcp"
  tags              = var.base_tags
}

/*
    -1 as value in ip_protocol is not secure. But for www_open it's OK.
    Better to specify strict port range and protocols.
*/

resource "aws_vpc_security_group_egress_rule" "to_terraform_vpc" {
  security_group_id = aws_security_group.by_terraform_www_open.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
  tags              = var.base_tags
}
