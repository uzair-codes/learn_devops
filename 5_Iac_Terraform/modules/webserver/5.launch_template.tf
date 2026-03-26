
resource "aws_launch_template" "webserver_lt" {
  name          = var.launch_template_name
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  network_interfaces {
    security_groups             = [aws_security_group.webservers_sg.id]
    associate_public_ip_address = false
  }

  # user_data = base64encode(file(var.user_data_script_path))
  # base64encode converts normal text into Base64 format 
  # it is used to convert the user_data script into a format that can be passed to AWS. 
  # AWS expects user_data to be in base64 format, so we use the base64encode function to 
  # convert our script before passing it to the launch template.

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Webservers"
      Role = "Webservers"
    }
  }
}