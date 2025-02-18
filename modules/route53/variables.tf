variable "domain_name" {
  type = string
  description = "domain name of website"
}

variable "cdn_domain_name" {
  type = string
  description = "cloudfront domain name"
}

variable "cdn_hosted_zone_id" {
  type = string
  description = "cloudfront hosted zone id"
}