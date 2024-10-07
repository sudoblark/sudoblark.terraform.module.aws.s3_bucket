# Input variable definitions
variable "environment" {
  description = "Which environment this is being instantiated in."
  type        = string
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Must be either dev, test or prod"
  }
}

variable "application_name" {
  type        = string
  description = "Name of the application utilising bucket."
}

variable "bucket_name_suffix" {
  type        = string
  description = "S3 bucket name prefix"
}

variable "access_log_bucket" {
  default     = null
  description = "Access Log target S3 bucket, defaults to null."
  type        = string
}

variable "enable_cmk_kms" {
  type        = bool
  default     = false
  description = "If we should use a customer managed KMS key for bucket encryption, defaults to False."
}

variable "enable_event_bridge" {
  type        = bool
  default     = false
  description = "Whether we should enable event bridge, defaults to False."
}

variable "enable_versioning" {
  type        = bool
  default     = false
  description = "Whether we should enable bucket versioning, defaults to False."
}

variable "bucket_policy_json" {
  type        = string
  default     = null
  description = "Bucket JSON  policy to utilise, defaults to null (i.e. no policy)."
}
variable "attach_policy" {
  type        = bool
  default     = false
  description = "Whether we wish to attach a custom policy or not, defaults to False."
}

variable "log_bucket_prefix" {
  type        = string
  description = "Prefix to use when writing logs to access_log_bucket."
}

variable "days_expiration" {
  type        = number
  default     = 365
  description = "Length of time objects remain in bucket before deletion, defaults to 365. Set to -1 to disable."
}

variable "mutlipart_expiration" {
  type        = number
  default     = 7
  description = "Length of time multipart objects remain in bucket before deletion, defaults to 7. Set to -1 to disable."
}
