output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "s3_bucket_origin_name" {
  description = "The origin domain name, looks like this: your-unique-bucket-name.s3.us-east-2.amazonaws.com"
  value       = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}