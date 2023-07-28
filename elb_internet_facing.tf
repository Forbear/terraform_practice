
locals {
  lb_name       = "${var.environment}-www-open-NLB"
  tg_name       = "${var.environment}-front-tg"
  listener_name = "${var.environment}-listener"
  protocol      = "TCP"
}

resource "aws_lb" "www_open" {
  count              = module.perimeter_network.internet_facing ? 1 : 0
  name               = "www-open-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = module.perimeter_network.subnets
  tags               = merge(var.base_tags, { Name = local.lb_name })
  depends_on         = [module.perimeter_network, ]
}

resource "aws_lb_target_group" "perimeter_web" {
  name     = "front-target-group"
  port     = 80
  protocol = local.protocol
  vpc_id   = module.perimeter_network.vpc_id
  health_check {
    enabled  = true
    interval = 15
    port     = 80
    protocol = local.protocol
  }
  tags       = merge(var.base_tags, { Name = local.tg_name })
  depends_on = [aws_lb.www_open, ]
}

resource "aws_lb_listener" "www_open_front" {
  count             = length(aws_lb.www_open) > 0 ? 1 : 0
  load_balancer_arn = aws_lb.www_open[0].arn
  port              = 80
  protocol          = local.protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.perimeter_web.arn
  }
  tags       = merge(var.base_tags, { Name = local.listener_name })
  depends_on = [aws_lb.www_open, ]
}
