
locals {
  instance_name = "${var.environment}-${var.purpose}-instance"
  lt_name       = "${var.environment}-${var.purpose}-template"
}

data "aws_ami" "amazon2_minimal_latest" {
  most_recent = true
  owners      = ["self", "amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-minimal-hvm*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "free_tier_amazon2_minimal_latest" {
  name          = "FreeTierAmazon2LaunchTemplate"
  instance_type = var.free_tier_instance_type
  image_id      = data.aws_ami.amazon2_minimal_latest.id
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
  }
  tag_specifications {
    resource_type = "instance"
    tags          = merge(var.base_tags, { Name = local.instance_name })
  }
  tags = merge(var.base_tags, { Name = local.lt_name })
}
