
locals {
  lb_name       = "${var.environment}-www-open-NLB"
  tg_name       = "${var.environment}-front-tg"
  listener_name = "${var.environment}-listener"
  protocol      = "TCP"
  subnets       = [for subnet in aws_subnet.perimeter : subnet.id]
}

resource "aws_lb" "www_open" {
  name               = "www-open-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = local.subnets
  tags               = merge(var.base_tags, { Name = local.lb_name })
  depends_on         = [aws_internet_gateway.perimeter, ]
}

resource "aws_lb_target_group" "perimeter_web" {
  name     = "front-target-group"
  port     = 80
  protocol = local.protocol
  vpc_id   = aws_vpc.perimeter.id
  health_check {
    enabled  = true
    interval = 15
    port     = 80
    protocol = local.protocol
  }
  tags = merge(var.base_tags, { Name = local.tg_name })
}

resource "aws_lb_listener" "www_open_front" {
  load_balancer_arn = aws_lb.www_open.arn
  port              = 80
  protocol          = local.protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.perimeter_web.arn
  }
  tags = merge(var.base_tags, { Name = local.listener_name })
}
