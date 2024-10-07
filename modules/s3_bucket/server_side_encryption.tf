resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  count  = var.enable_cmk_kms ? 0 : 1
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}