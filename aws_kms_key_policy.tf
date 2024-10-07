locals {
  actual_kms_key_policies = { for idx, bucket in flatten([
    for bucket in var.raw_s3_buckets : {
      bucket_name : bucket.name,
      key_id : data.aws_kms_key.known_keys[bucket.name].id,
      policy : data.aws_iam_policy_document.kms_key_policies[bucket.name].json
    } if bucket.enable_kms
  ]) : bucket.bucket_name => bucket }
}

resource "aws_kms_key_policy" "policies" {
  for_each = local.actual_kms_key_policies

  key_id = each.value["key_id"]
  policy = each.value["policy"]

  depends_on = [
    module.s3_bucket,
    data.aws_iam_policy_document.kms_key_policies,
    data.aws_kms_key.known_keys
  ]
}