# 1. Create a VPC 192.168.1.0/24
resource "aws_vpc" "prod_vpc" {
  cidr_block = "192.168.1.0/24"
  tags = {
    Name = "Production VPC"
  }
}


# 2. Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
    Name = "Production IGW"
  }
}

# 3. Create a Subnet in the VPC
resource "aws_subnet" "prod_subnet" {
  vpc_id = aws_vpc.prod_vpc.id
  cidr_block = "192.168.1.0/25"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Production Subnet"
  }
}

# 4. Create Custom Route Table and associate it with the VPC 
resource "aws_route_table" "prod_route_table" {
  vpc_id = aws_vpc.prod_vpc.id
  route {
   # This route directs all IPv4 traffic to the internet gateway
   # Enabling outbound internet access for resources in the VPC.
   # Makes this subnet public by allowing it to send traffic to the internet.

    cidr_block = "0.0.0.0/0"     
    gateway_id = aws_internet_gateway.prod_igw.id
  }
  tags = {
    Name = "Production Route Table"
  }
}

# 5. Associate the Route Table with the Subnet
resource "aws_route_table_association"  "prod_route_table_assoc" {
  subnet_id = aws_subnet.prod_subnet.id
  route_table_id = aws_route_table.prod_route_table.id
}

# 6. Create a Security Group (reference 5-security_gorup.tf)


# 7. Create an EC2 instance
resource "aws_instance" "prod_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.prod_subnet.id
  vpc_security_group_ids = [aws_security_group.prod_sg.id]
  availability_zone = "ap-south-1a"
  associate_public_ip_address = true
  key_name = "ssh-kp"
  tags = {
    Name = "Production Server"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update && sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo systemctl enable apache2
              sudo bash -c 'echo "<h1>Hello, World!</h1>" > /var/www/html/index.html'
              EOF 
}

# 8. Create a Custom ENI  with an ip in the subnet that was created in step 4
resource "aws_network_interface" "prod_ni" {
  subnet_id = aws_subnet.prod_subnet.id
  security_groups = [aws_security_group.prod_sg.id]
  private_ips = ["192.168.1.10"]
  tags = {
    Name = "Production Network Interface"
  }
}
# 9. Attach the network interface to the EC2 instance
resource "aws_network_interface_attachment" "prod_ni_attachment" {
  instance_id = aws_instance.prod_server.id
  network_interface_id = aws_network_interface.prod_ni.id
  device_index = 0
}



# Input "ami, instance_type, key_name, availability_zone and VPC CIDR" as variables to make the code reusable for different environments.
# Output the public IP of the EC2 instance.
# Set Remote Backend for state management and versioning.