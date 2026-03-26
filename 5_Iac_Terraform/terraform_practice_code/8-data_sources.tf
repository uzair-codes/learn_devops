# Data Sources : A Data Source in Terraform is used to get information about something that already exists, such as an existing resource or a piece of data. 
# It allows you to reference and use that information in your Terraform configuration.

# data  "TYPE"   "LOCAL_NAME" {
#   # Configuration arguments for the data source
# }

data "aws_ami" "ubuntu" {
  most_recent = true             # This tells Terraform to fetch the most recent AMI that matches the specified criteria.
  owners      = ["099720109477"] # This specifies the owner of the AMI. In this case, "099720109477" is the owner ID for Canonical, the company behind Ubuntu.

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

