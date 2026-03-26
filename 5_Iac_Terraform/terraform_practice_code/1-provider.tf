# The terraform block is used to define:
# 1. Terraform version constraints 
# 2. Provider source and version 
# 3. Backend configuration for state management. 
# It ensures consistency across environments and prevents breaking changes from provider updates.

terraform {
  required_version = ">= 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.32.0"
    }
  }

  backend "s3" {
    bucket       = "uzair-2252-state-backend"
    key          = "default/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt = true
    foce_destroy = true
  }
}

# Define Provider
provider "aws" {
  region = "ap-south-1"
}