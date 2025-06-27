terraform {
  backend "s3" {
    bucket         = "poc-pre-prod-tfstate-2025"
    key            = "pre-prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "poc-pre-prod-locks"
    encrypt        = true
  }
}
