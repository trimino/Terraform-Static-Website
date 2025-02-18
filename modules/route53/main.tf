data "aws_route53_zone" "domain" {
  name         = var.domain_name
  private_zone = false
}


resource "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cdn_domain_name
    zone_id                = var.cdn_hosted_zone_id
    evaluate_target_health = false
  }
}