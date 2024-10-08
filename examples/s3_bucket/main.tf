terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.61.0"
    }
  }
  required_version = "~> 1.5.0"
}

provider "aws" {
  region = "eu-west-2"
}

module "s3_bucket" {

  source = "github.com/sudoblark/sudoblark.terraform.module.aws.s3_bucket?ref=1.0.2"

  application_name = var.application_name
  environment      = var.environment
  raw_s3_buckets   = local.raw_s3_buckets
}