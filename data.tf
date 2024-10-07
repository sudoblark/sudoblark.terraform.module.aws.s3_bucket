locals {
  known_kms_keys = { for idx, bucket in flatten([
    for bucket in var.raw_s3_buckets : {
      bucket_name : bucket.name,
      key_id : one(module.s3_bucket[bucket.name].kms_arn)
    } if bucket.enable_kms
  ]) : bucket.bucket_name => bucket }
}

# Retrieve the current AWS Account info
data "aws_caller_identity" "current_account" {}

# Get current region
data "aws_region" "current_region" {}

# Lookup known KMS keys for easy reference across stack
data "aws_kms_key" "known_keys" {
  for_each = local.known_kms_keys
  key_id   = each.value["key_id"]

  depends_on = [
    module.s3_bucket
  ]
}