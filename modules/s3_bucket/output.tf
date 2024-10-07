output "s3_bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}

output "s3_bucket_id" {
  value = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}

output "kms_arn" {
  value = aws_kms_key.customer_managed_key[*].arn
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}
