resource "aws_s3_bucket_notification" "bucket_notification" {
  count       = var.enable_event_bridge ? 1 : 0
  bucket      = aws_s3_bucket.s3_bucket.id
  eventbridge = true

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}