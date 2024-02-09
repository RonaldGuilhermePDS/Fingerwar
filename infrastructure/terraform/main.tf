terraform {
  required_version = "1.7.2"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "fingerwar-bucket" {
  bucket = "tfstate-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_versioning" "remote-state" {
  bucket = aws_s3_bucket.fingerwar-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "terraform-tfstate" {
  bucket = aws_s3_bucket_versioning.remote-state.id
  key    = "infrastructure/terraform/terraform.tfstate"
  source = "terraform.tfstate"
}