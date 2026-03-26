resource "aws_lb" "webserver_alb" {
  name               = var.webserver_alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  # List of subnet IDs to attach to the LB
  subnets            = [for subnet in aws_subnet.public_subnets : subnet.id] 
  tags = {
    Name = "Webserver_ALB"
    Role= "Webserver_ALB"
  }
}