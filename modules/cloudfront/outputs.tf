output "cdn_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "cdn_hosted_zone_id" {
  value = aws_cloudfront_distribution.cdn.hosted_zone_id
}

output "cdn_id" {
  value = aws_cloudfront_distribution.cdn.id
}