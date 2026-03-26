resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.public_subnets[0].id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion_Host"
    Role= "Bastion_Host"
  }
}

resource "aws_eip" "bastion_public_ip" {
  domain = "vpc"
  instance = aws_instance.bastion_host.id
  tags = {
    Name = "Bastion Host Public IP"
  }
}