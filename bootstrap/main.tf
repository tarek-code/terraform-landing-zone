terraform {
  backend "s3" {
    bucket         = "poc-pre-prod-tfstate-2025"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "poc-pre-prod-locks"
    encrypt        = true
  }
}

# PROD resources
resource "aws_s3_bucket" "tf_state_prod" {
  bucket = "poc-prod-tfstate-2025"

  tags = {
    Name        = "poc-prod-tfstate-2025"
    Environment = "prod"
  }
}

resource "aws_dynamodb_table" "tf_lock_prod" {
  name         = "poc-prod-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "poc-prod-locks"
    Environment = "prod"
  }
}

# PRE-PROD resources
resource "aws_s3_bucket" "tf_state_preprod" {
  bucket = "poc-pre-prod-tfstate-2025"

  tags = {
    Name        = "poc-pre-prod-tfstate-2025"
    Environment = "pre-prod"
  }
}

resource "aws_dynamodb_table" "tf_lock_preprod" {
  name         = "poc-pre-prod-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "poc-pre-prod-locks"
    Environment = "pre-prod"
  }
}
