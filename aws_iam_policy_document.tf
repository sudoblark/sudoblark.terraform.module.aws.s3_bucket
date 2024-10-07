locals {
  actual_iam_policy_documents = { for idx, bucket in flatten([
    for bucket in var.raw_s3_buckets : {
      bucket_name : bucket.name,
      principals : bucket.kms_allowed_principals
    } if bucket.enable_kms
  ]) : bucket.bucket_name => bucket }
}

data "aws_iam_policy_document" "kms_key_policies" {
  for_each = local.actual_iam_policy_documents

  statement {
    sid = "Enable IAM User Permissions"
    actions = [
      "kms:*"
    ]
    resources = ["*"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current_account.id}:root"
      ]
    }
  }

  dynamic "statement" {
    for_each = each.value["principals"]

    content {
      actions = [
        "kms:DescribeKey",
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey",
        "kms:GenerateDataKeyWithoutPlaintext"
      ]
      resources = ["*"]

      principals {
        type        = statement.value["type"]
        identifiers = statement.value["identifiers"]
      }
    }
  }
}