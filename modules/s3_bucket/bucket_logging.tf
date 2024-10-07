resource "aws_s3_bucket_logging" "bucket_logging" {
  count         = var.access_log_bucket != null ? 1 : 0
  bucket        = aws_s3_bucket.s3_bucket.id
  target_bucket = var.access_log_bucket
  target_prefix = "${var.log_bucket_prefix}/${aws_s3_bucket.s3_bucket.id}/"

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}