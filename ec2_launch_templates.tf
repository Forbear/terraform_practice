
locals {
  instance_name = "${var.environment}-instance"
  lt_name       = "${var.environment}-template"
}

data "aws_ami" "amazon2_latest" {
  most_recent = true
  owners      = ["self", "amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.2*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "free_tier_perimeter_amazon2_latest" {
  name                   = "FreeTierAmazon2LaunchTemplate"
  instance_type          = var.free_tier_instance_type
  image_id               = data.aws_ami.amazon2_latest.id
  update_default_version = true
  user_data              = filebase64("./user_data/nginx_install.sh")
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_base.name
  }
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = [aws_security_group.nginx_servers_sg.id, aws_security_group.inbound_only_ssh.id, ]
    subnet_id                   = module.perimeter_network.subnets[0]
  }
  tag_specifications {
    resource_type = "instance"
    tags          = merge(var.base_tags, { Name = local.instance_name })
  }
  tags = merge(var.base_tags, { Name = local.lt_name })
}
