# Creating Security Group to allow SSH access
###### First Way ####################
# defining rules inside "aws_security_goup" block using ingress and egress block
resource "aws_security_group" "ssh_http_https_access" {
  name        = "ssh_http_https_access"
  description = "Allow SSH HTTP HTTPS access"

  # use dynamic blocks to allow multiple ingress rules
  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

###### Second Way ####################
# defin rules using seperate blocks aws_vpc_security_group_ingress_rule and aws_vpc_security_group_egress_rule
resource "aws_security_group" "prod_sg" {
  name        = "Production SG"
  description = "Allow SSH, HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.prod_vpc.id

  tags = {
    Name = "Production Security Group"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.prod_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  tags = {
    Name = "Allow HTTPS Traffic"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.prod_sg.id
  cidr_ipv4         = "0.0.0.0/0"  
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  tags = {
    Name = "Allow SSH Traffic"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.prod_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  tags = {
    Name = "Allow HTTP Traffic"
  }
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.prod_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Automate Security Group Ingress Rules using for_each and the ports variable
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_http_https_ipv4" {
  for_each = var.ports
  security_group_id = aws_security_group.prod_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.value
  to_port           = each.value
  ip_protocol       = "tcp"
  tags = {
    Name = "Allow ${each.key} Traffic"
  }
}
