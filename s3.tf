/* resource "aws_s3_bucket" "atyra_terraform_bucket" {
  bucket = "atyra_terraform_bucket"
  tags = {
    Name = "atyra_terraform_bucket"
  }
}

resource "aws_s3_bucket_versioning" "atyra_terraform_a" {
  bucket = aws_s3_bucket.atyra_terraform_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

terraform {
  backend "s3" {
    bucket = "atyra_terraform"
    region = "us-east-1"
    encrypt = true
  }
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
 */