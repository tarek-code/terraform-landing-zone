terraform {
  backend "s3" {
    bucket         = "poc-prod-tfstate-2025"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "poc-prod-locks"
    encrypt        = true
  }
}
 
