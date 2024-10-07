resource "aws_kms_key" "customer_managed_key" {
  count               = var.enable_cmk_kms ? 1 : 0
  description         = "S3 key to encrypt contents within ${local.bucket_name}}"
  enable_key_rotation = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cmk" {
  count  = var.enable_cmk_kms ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.customer_managed_key[count.index].id
      sse_algorithm     = "aws:kms"
    }
  }
  depends_on = [
    aws_kms_key.customer_managed_key,
    aws_s3_bucket.s3_bucket
  ]
}