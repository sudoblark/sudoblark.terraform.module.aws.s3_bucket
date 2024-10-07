resource "aws_s3_bucket_policy" "policy" {
  count  = var.attach_policy ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id
  policy = var.bucket_policy_json

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}