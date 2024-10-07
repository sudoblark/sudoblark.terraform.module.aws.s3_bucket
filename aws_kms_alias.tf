locals {
  actual_kms_key_aliases = { for idx, bucket in flatten([
    for bucket in var.raw_s3_buckets : {
      bucket_name : bucket.name,
      key_id : data.aws_kms_key.known_keys[bucket.name].id,
      alias : format("alias/%s", module.s3_bucket[bucket.name].s3_bucket_name)
    } if bucket.enable_kms
  ]) : bucket.bucket_name => bucket }
}

resource "aws_kms_alias" "aliases" {
  for_each = local.actual_kms_key_aliases

  name          = each.value["alias"]
  target_key_id = each.value["key_id"]

  depends_on = [
    module.s3_bucket,
    data.aws_kms_key.known_keys
  ]
}