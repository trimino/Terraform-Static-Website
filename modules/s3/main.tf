data "aws_caller_identity" "current" {}

# Create the S3 bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
}

# Enforce bucket ownership and block public ACLs
resource "aws_s3_bucket_ownership_controls" "s3_ownership_controls" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    # enforces that the bucket owner (you) fully controls all objects in the bucket
    # Removes ACLs (Access Control Lists) → AWS ignores ACLs for all objects in the bucket
    # Ensures Full Control → Only the bucket owner (your AWS account) can manage objects
    # Prevents Cross-Account Issues → Even if another AWS account uploads an object, you still own it.
    object_ownership = "BucketOwnerEnforced"
  }
}

# Block all public access settings
resource "aws_s3_bucket_public_access_block" "static_site" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true  # Prevents new ACLs from granting public access
  ignore_public_acls      = true  # Ignores all ACLs that allow public access
  block_public_policy     = true  # Blocks new public bucket policies
  restrict_public_buckets = true  # Prevents any existing public access policies from taking effect
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "s3:GetObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cdn_id}"
          }
        }
      }
    ]
  })
}
