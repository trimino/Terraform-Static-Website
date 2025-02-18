variable "s3_bucket_origin_name" {
  type = string
  description = "bucket origin name"
}

variable "acm_certificate_arn" {
  type = string
  description = "acm certificate arn"
}

variable "domain_name" {
  type = string
}