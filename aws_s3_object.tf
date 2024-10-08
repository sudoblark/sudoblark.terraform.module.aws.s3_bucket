locals {
  s3_prefixes = flatten([
    for bucket in var.raw_s3_buckets : [
      for prefix in bucket.prefixes : {
        bucket : bucket.name
        key : prefix
        identifier = format("%s/%s", bucket.name, prefix)
      } if length(bucket.prefixes) > 0
    ]
  ])
}

resource "aws_s3_object" "prefixes" {
  for_each = { for prefix in local.s3_prefixes : prefix.identifier => prefix }

  bucket = module.s3_bucket[each.value["bucket"]].s3_bucket_name
  key    = each.value["key"]
  source = "/dev/null"

  depends_on = [
    module.s3_bucket
  ]
}