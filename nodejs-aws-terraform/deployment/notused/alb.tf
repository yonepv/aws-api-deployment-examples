#-------------------------------------------------------------------------------
# Application load balancer
resource "aws_alb_target_group" "alb_tg_http" {
  name     = "nodejs-example-alb-tg"
  port     = 80 #var.aws_ecs_ec2_tg_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id #var.aws_ecs_vpc_id
  target_type = "ip"
  lifecycle {
    create_before_destroy = true
  }
  health_check {
    enabled             = true
    interval            = 30
    path                = "/healthcheck" #var.aws_ecs_health_check_path
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 5
    unhealthy_threshold = 3
    matcher             = "200"
  }
}

resource "aws_alb" "alb_appl" {
  name            = "nodejs-example-alb"
  internal        = true
  subnets         = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id] #var.aws_ecs_web_subnets_id
  #security_groups = [var.aws_ecs_web_security_group_id, var.aws_ecs_app_security_group_id]
  security_groups = [aws_security_group.security_group_nodejs_example_app.id]
}

resource "aws_lb_listener" "alb_listener_https" {
  load_balancer_arn  = aws_alb.alb_appl.arn
  port               = 80 #var.aws_ecs_ec2_tg_port
  protocol           = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_tg_http.arn
  }
}