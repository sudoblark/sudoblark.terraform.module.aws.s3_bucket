resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_rule" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    id     = "multipart_upload_default_rule"
    status = var.mutlipart_expiration == -1 ? "Disabled" : "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = var.mutlipart_expiration
    }
  }
  rule {
    id     = "expiration_default_rule"
    status = var.days_expiration == -1 ? "Disabled" : "Enabled"

    expiration {
      days = var.days_expiration
    }
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}