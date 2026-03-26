# 1- Create a VPC for the web application
resource "aws_vpc" "webserver" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "WebServer-VPC"
  }
}
# 2- Create Internet Gateway
resource "aws_internet_gateway" "webserver_igw" {
  vpc_id = aws_vpc.webserver.id
  tags = {
    Name = "WebServer-IGW"
  }
}
# 3- Create a public subnets in each availability zone
resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.webserver.id
  # Create as many public subnets as there are CIDR blocks in the list
  count             = length(var.pub_cidr)
  cidr_block        = var.pub_cidr[count.index]
  availability_zone = local.azs[count.index] # Using the corresponding AZ from the list of availability zones
  tags = {
    Name = "WebServer-Public-Subnet-${count.index + 1}"
  }
}
# 4- Create a private subnets in each availability zone
resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.webserver.id
  count             = length(var.pvt_cidr)
  cidr_block        = var.pvt_cidr[count.index]
  availability_zone = local.azs[count.index]
  tags = {
    Name = "WebServer-Private-Subnet-${count.index + 1}"
  }
}

# 5- Create a route table for the public subnets
resource "aws_route_table" "webserver_pub_rtb" {
  vpc_id = aws_vpc.webserver.id
  route {
    cidr_block = "0.0.0.0/0" # Default Route 
    gateway_id = aws_internet_gateway.webserver_igw.id
  }
  tags = {
    Name = "WebServer-Public-Route-Table"
  }
}
# 7- Associate the public subnets with the route table
resource "aws_route_table_association" "rtb_assoc_pub" {
  count          = length(var.pub_cidr)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.webserver_pub_rtb.id
}

# Create NAT Gateway per AZ in public subnets to allow private subnet to access internet
# Note: NAT Gateway requires an Elastic IP, so we need to create one for each NAT Gateway.
# NAT Gateway depends on IGW

########### NAT Gateway per AZ ###########
resource "aws_eip" "nat_eips" {
  count  = length(local.azs)
  domain = "vpc"
  tags = {
    Name = "EIP for NAT Gateway AZ-${count.index + 1}"
  }
}
resource "aws_nat_gateway" "nat_gws" {
  count         = length(local.azs)
  allocation_id = aws_eip.nat_eips[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = "NAT GW AZ-${count.index + 1}"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.webserver_igw]
}
# Create a route table for the private subnets in AZ
resource "aws_route_table" "webserver_pvt_rtb" {
  vpc_id = aws_vpc.webserver.id
  count  = length(local.azs)
  route {
    cidr_block     = "0.0.0.0/0" # Default Route 
    nat_gateway_id = aws_nat_gateway.nat_gws[count.index].id
  }
  tags = {
    Name = "WebServer-Private-Route-Table-AZ-${count.index + 1}"
  }
}
# Associate the private subnet in with the route table
resource "aws_route_table_association" "rtb_assoc_prvt" {
  count          = length(local.azs)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.webserver_pvt_rtb[count.index].id
}

