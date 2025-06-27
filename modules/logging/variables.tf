variable "environment" {
  description = "Environment (prod/pre-prod)"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket to store logs"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC for flow logs"
  type        = string
}
