resource "aws_lb_target_group" "webserver_alb_tg" {
  name        = var.webserver_alb_tg_name
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.webserver.id

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    matcher             = "200-399"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "webserver_alb_listener" {
  load_balancer_arn = aws_lb.webserver_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver_alb_tg.arn
  }

}