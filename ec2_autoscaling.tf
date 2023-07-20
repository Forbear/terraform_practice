
locals {
  asg_nginx_name = "${var.environment}-as-nginx"
}

resource "aws_autoscaling_group" "nginx" {
  name                = "ASG-nginx"
  max_size            = 2
  min_size            = 1
  desired_capacity    = 1
  health_check_type   = "ELB"
  target_group_arns   = [aws_lb_target_group.perimeter_web.arn, ]
  placement_group     = aws_placement_group.perimeter.id
  vpc_zone_identifier = module.perimeter_network.subnets
  launch_template {
    id      = aws_launch_template.free_tier_perimeter_amazon2_latest.id
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true
  }
  dynamic "tag" {
    for_each = merge(var.base_tags, { Name = local.asg_nginx_name })
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
