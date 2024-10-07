# sudoblark.terraform.module.aws.s3_bucket
Terraform module to create N number of S3 buckets. - repo managed by sudoblark.terraform.github

## Developer documentation
The below documentation is intended to assist a developer with interacting with the Terraform module in order to add,
remove or update functionality.

### Pre-requisites
* terraform_docs

```sh
brew install terraform_docs
```

* tfenv
```sh
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
```

* Virtual environment with pre-commit installed

```sh
python3 -m venv venv
source venv/bin/activate
pip install pre-commit
```
### Pre-commit hooks
This repository utilises pre-commit in order to ensure a base level of quality on every commit. The hooks
may be installed as follows:

```sh
source venv/bin/activate
pip install pre-commit
pre-commit install
pre-commit run --all-files
```

# Module documentation
The below documentation is intended to assist users in utilising the module, the main thing to note is the
[data structure](#data-structure) section which outlines the interface by which users are expected to interact with
the module itself, and the [examples](#examples) section which has examples of how to utilise the module.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | ./modules/s3_bucket | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.aliases](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key_policy.policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_s3_object.prefixes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_caller_identity.current_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.kms_key_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.known_keys](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | Name of the application utilising resource. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Which environment this is being instantiated in. | `string` | n/a | yes |
| <a name="input_raw_s3_buckets"></a> [raw\_s3\_buckets](#input\_raw\_s3\_buckets) | Data structure<br>---------------<br>A list of dictionaries, where each dictionary has the following attributes:<br><br>REQUIRED<br>---------<br>- name      : The name of the bucket.<br><br><br>OPTIONAL<br>---------<br>- log\_bucket                 : Target bucket name for access logging, defaults to null and thus not enabled.<br>- prefixes                   : A list of prefixes to pre-create in the bucket, defaults to empty list.<br>- versioning                 : Boolean to determine if versioning is enabled or not. Defaults to true.<br>- bucket\_policy\_json         : JSON bucket policy. Defaults to null. Use to restrict access to the bucket in a more granular fashion.<br>- days\_retention             : How many days an item is retained in the bucket before being deleted. Defaults to 365.<br>- multipart\_retention        : How many days incomplete multipart uploads should remain in bucket. Defaults to 7.<br>- enable\_event\_bridge        : Whether to enable event\_bridge on the bucket. Defaults to False.<br>- enable\_kms                 : Whether to enable KMS encryption of objects at rest. Defaults to False.<br>- kms\_allowed\_principals     : An list of dictionaries (defaults to empty list), which each defines:<br>-- type                      : A string defining what type the principle(s) is/are<br>-- identifiers               : A list of strings, where each string is an allowed principle | <pre>list(<br>    object({<br>      name                = string,<br>      log_bucket          = optional(string, null)<br>      prefixes            = optional(list(string), []),<br>      versioning          = optional(bool, true),<br>      bucket_policy_json  = optional(string, null),<br>      days_retention      = optional(number, 365),<br>      multipart_retention = optional(number, 7)<br>      enable_event_bridge = optional(bool, false),<br>      enable_kms          = optional(bool, false),<br>      kms_allowed_principals = optional(list(<br>        object({<br>          type        = string,<br>          identifiers = list(string),<br>        })<br>      ), [])<br>    })<br>  )</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Data structure
```
Data structure
---------------
A list of dictionaries, where each dictionary has the following attributes:

REQUIRED
---------
- name      : The name of the bucket.


OPTIONAL
---------
- log_bucket                 : Target bucket name for access logging, defaults to null and thus not enabled.
- prefixes                   : A list of prefixes to pre-create in the bucket, defaults to empty list.
- versioning                 : Boolean to determine if versioning is enabled or not. Defaults to true.
- bucket_policy_json         : JSON bucket policy. Defaults to null. Use to restrict access to the bucket in a more granular fashion.
- days_retention             : How many days an item is retained in the bucket before being deleted. Defaults to 365.
- multipart_retention        : How many days incomplete multipart uploads should remain in bucket. Defaults to 7.
- enable_event_bridge        : Whether to enable event_bridge on the bucket. Defaults to False.
- enable_kms                 : Whether to enable KMS encryption of objects at rest. Defaults to False.
- kms_allowed_principals     : An list of dictionaries (defaults to empty list), which each defines:
-- type                      : A string defining what type the principle(s) is/are
-- identifiers               : A list of strings, where each string is an allowed principle
```

## Examples
See `examples` folder for an example setup.
