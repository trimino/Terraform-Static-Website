variable "domain_name" {
  description = "The domain name to use for the website"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name
  cdn_id         = module.cloudfront.cdn_id
}

module "route53" {
  source             = "./modules/route53"
  domain_name        = var.domain_name
  cdn_domain_name    = module.cloudfront.cdn_domain_name
  cdn_hosted_zone_id = module.cloudfront.cdn_hosted_zone_id
}

module "certificate" {
  source         = "./modules/cert"
  domain_name    = var.domain_name
  hosted_zone_id = module.route53.route53_zone_id
}


module "cloudfront" {
  source                = "./modules/cloudfront"
  s3_bucket_origin_name = module.s3.s3_bucket_origin_name
  acm_certificate_arn   = module.certificate.acm_certificate_arn
  domain_name           = var.domain_name
}