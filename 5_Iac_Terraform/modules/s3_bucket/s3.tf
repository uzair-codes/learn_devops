# -------------------------
# Get Current Account ID
# -------------------------
data "aws_caller_identity" "current_caller" {}

locals {
  account_id = data.aws_caller_identity.current_caller.account_id
}

# -------------------------
# Create S3 Bucket
# -------------------------
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${local.account_id}-terraform-states" # Globally unique bucket name
  tags = {
    Name = "s3_remote_backend"
  }
  # Because AWS does not allow deletion of non-empty buckets. 
  # If versioning is enabled, all object versions must also be deleted.
  # We can solve it using force_destroy = true, but use it with caution as it will delete all objects in the bucket when the bucket is destroyed.
  force_destroy = true # This will allow Terraform to delete the bucket even if it contains objects. Use with caution.
   
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.remote_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}