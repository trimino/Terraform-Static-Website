output "route53_zone_id" {
  description = "The Hosted Zone ID for the domain"
  value       = data.aws_route53_zone.domain.zone_id
}