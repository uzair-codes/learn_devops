
# The Availability Zones data source allows access to the list of AWS Availability Zones
# which can be accessed by an AWS account within the region configured in the provider.

data "aws_availability_zones" "AZs" {
  state = "available"
}
# data.aws_availability_zones.AZs.names will return a list of names of AZs in the region, for example: ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
# slice(list, start, end) will return a subset of the list from index 'start' to 'end-1'. 
# For example, slice(data.aws_availability_zones.AZs.names, 0, 2) will return the first two AZ names: ["ap-south-1a", "ap-south-1b"].
# So azs will contain the first two availability zones in the region, which can be used to create resources in those specific AZs.
locals {
  azs = slice(data.aws_availability_zones.AZs.names, 0, length(var.pub_cidr)) # Assuming we want to create as many AZs as there are public CIDR blocks
  # for example, azs = ["ap-south-1a", "ap-south-1b"]
}



# The AWS AMI data source allows access to information about an Amazon Machine Image (AMI) available in the region configured in the provider.
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical, the publisher of Ubuntu AMIs
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}