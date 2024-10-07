locals {
  bucket_name = lower("${var.environment}-${var.application_name}-${var.bucket_name_suffix}")
}