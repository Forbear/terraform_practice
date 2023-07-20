
locals {
  www_sg_name          = "${var.environment}-www-open-sg"
  nginx_sg_name        = "${var.environment}-nginx-sg"
  ssh_inbound_sg_name  = "${var.environment}-inbound-ssh-sg"
  ssh_outbound_sg_name = "${var.environment}-outbound-ssh-sg"
  ping_sg_name         = "${var.environment}-ping-sg"
}

#### SG initially created for internet facing ALB/resource. ####

resource "aws_security_group" "www_open" {
  name        = "www_open_sg"
  description = "SG to open world wide web access to resources/apps."
  vpc_id      = module.perimeter_network.vpc_id
  tags        = merge(var.base_tags, { Name = local.www_sg_name })
}

resource "aws_security_group_rule" "http_https_ingress_www_open" {
  for_each          = toset(["80", "443", ])
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "TCP"
  from_port         = each.key
  to_port           = each.key
  type              = "ingress"
  security_group_id = aws_security_group.www_open.id
}

resource "aws_security_group_rule" "all_egress_www_open" {
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "TCP"
  from_port         = 0
  to_port           = 65353
  type              = "egress"
  security_group_id = aws_security_group.www_open.id
}

#### SG configuration for NGINX servers. ####

resource "aws_security_group" "nginx_servers_sg" {
  name        = "nginx_server_sg"
  description = "SG for nginx servers."
  vpc_id      = module.perimeter_network.vpc_id
  tags        = merge(var.base_tags, { Name = local.nginx_sg_name })
}

resource "aws_security_group_rule" "http_https_ingress_nginx" {
  for_each          = toset(["80", "443", ])
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "TCP"
  from_port         = each.key
  to_port           = each.key
  type              = "ingress"
  security_group_id = aws_security_group.nginx_servers_sg.id
}

resource "aws_security_group_rule" "all_egress_nginx" {
  for_each          = toset(["80", "443", ])
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "TCP"
  from_port         = each.key
  to_port           = each.key
  type              = "egress"
  security_group_id = aws_security_group.nginx_servers_sg.id
}

#### SGs for ssh connect ####

resource "aws_security_group" "inbound_only_ssh" {
  name        = "ssh_inbound_sg"
  description = "SG for ssh connect."
  vpc_id      = module.perimeter_network.vpc_id
  tags        = merge(var.base_tags, { Name = local.ssh_inbound_sg_name })
}

resource "aws_security_group_rule" "ssh_ingress" {
  cidr_blocks       = ["10.0.0.0/16"]
  protocol          = "TCP"
  from_port         = 22
  to_port           = 22
  type              = "ingress"
  security_group_id = aws_security_group.inbound_only_ssh.id
}

/*
resource "aws_security_group_rule" "ssh_egress" {
  cidr_blocks       = ["10.0.0.0/16"]
  protocol          = "TCP"
  from_port         = 22
  to_port           = 22
  type              = "egress"
  security_group_id = aws_security_group.ssh.id
}
*/

resource "aws_security_group" "outbound_only_ssh" {
  name        = "ssh_outbound_sg"
  description = "SG for ssh connect."
  vpc_id      = module.perimeter_network.vpc_id
  tags        = merge(var.base_tags, { Name = local.ssh_outbound_sg_name })
}

resource "aws_security_group_rule" "ssh_egress" {
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "TCP"
  from_port         = 22
  to_port           = 22
  type              = "egress"
  security_group_id = aws_security_group.outbound_only_ssh.id
}
