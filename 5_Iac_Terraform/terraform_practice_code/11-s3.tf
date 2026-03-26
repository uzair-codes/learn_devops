
# This Terraform configuration file defines an AWS S3 bucket to be used as a backend for storing Terraform state files. 
# It also enables versioning on the bucket to maintain a history of changes to the state file, allowing for recovery from accidental deletions or overwrites.
resource "aws_s3_bucket" "state_backend" {
  bucket = "uzair-2252-state-backend"

  tags = {
    Name = "uzair-2252-state-backend"
  }
}

# Enable versioning on the S3 bucket to maintain a history of changes to the state file, allowing for recovery from accidental deletions or overwrites.
resource "aws_s3_bucket_versioning" "state_backend_versioning" {
  bucket = aws_s3_bucket.state_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}