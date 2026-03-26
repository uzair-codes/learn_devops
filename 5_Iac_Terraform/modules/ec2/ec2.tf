resource "aws_instance" "server" {
  count = var.num_of_instances
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.sever_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags = {
    Name = "Web_Server_${count.index + 1}"
    Role = "web"
  }
}
