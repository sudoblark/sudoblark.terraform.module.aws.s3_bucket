module "s3_bucket" {
  source = "./modules/s3_bucket"

  for_each = { for s3_bucket in var.raw_s3_buckets : s3_bucket.name => s3_bucket }

  environment      = var.environment
  application_name = var.application_name

  bucket_name_suffix  = each.value["name"]
  enable_cmk_kms      = each.value["enable_kms"]
  enable_versioning   = each.value["versioning"]
  enable_event_bridge = each.value["enable_event_bridge"]
  bucket_policy_json  = each.value["bucket_policy_json"]
  // i.e. only set to true if we're actually defining a bucket policy json in the first place
  attach_policy        = each.value["bucket_policy_json"] == null ? false : true
  days_expiration      = each.value["days_retention"]
  mutlipart_expiration = each.value["multipart_retention"]
  access_log_bucket    = each.value["log_bucket"]
  log_bucket_prefix    = "s3:/${data.aws_caller_identity.current_account.id}"
}

