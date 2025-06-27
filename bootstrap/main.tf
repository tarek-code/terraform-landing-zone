terraform {
  backend "s3" {
    bucket         = "poc-pre-prod-tfstate-2025"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "poc-pre-prod-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = var.bucket_name
    Environment = "pre-prod"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = var.dynamodb_table_name
    Environment = "pre-prod"
  }
}
