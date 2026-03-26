
resource "aws_autoscaling_group" "webserver_asg" {
  name             = var.autoscalig_grp_name
  min_size         = var.asg_min_capacity
  desired_capacity = var.asg_desired_capacity
  max_size         = var.asg_max_capacity
  # Where Will Servers Be Created?
  # This line, Loops through all private subnets, Takes their IDs, Places EC2 instances inside them.
  vpc_zone_identifier = [for subnet in aws_subnet.private_subnets : subnet.id]   

  launch_template {
    id      = aws_launch_template.webserver_lt.id
    version = "$Latest"
  }
  # Connect to Load Balancer, This connects ASG to a Target Group.
  # Meaning:
  # All EC2 instances will register to Load Balancer
  # Load Balancer will send traffic to them
  # So traffic flow becomes: User → Load Balancer → EC2 (inside ASG)
  target_group_arns = [aws_lb_target_group.webserver_alb_tg.arn]
 
  health_check_type         = "ELB" # Load Balancer will check if instance is healthy.
  health_check_grace_period = 900   # After launching a new server, wait 15 minutes before checking health.

  tag { #This adds a Name tag to instances.
    key                 = "Name"
    value               = "Webservers"
    propagate_at_launch = true # means Every EC2 created by ASG will automatically get this tag.
    # So all instances will have: Name = Webservers
  }
}