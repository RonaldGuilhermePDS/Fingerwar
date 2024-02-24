terraform {
  required_version = "1.7.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "vpc_dev" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
}


resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.vpc_dev.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_db_instance" "db_dev" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "16.2"
  instance_class       = "db.t3.micro"
  username             = var.database_username
  password             = var.database_password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_dev_subnet.id
}

resource "aws_db_subnet_group" "db_dev_subnet" {
  name       = "dbdevsubnet"
  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
}

resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.ig]
}
