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

resource "aws_vpc" "vpc_dev" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}
