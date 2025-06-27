variable "s3_bucket_name" {
  description = "The name of the S3 bucket for storing VPC flow logs"
  type        = string
}

variable "log_group_name" {
  description = "The name of the CloudWatch log group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to attach flow logs to"
  type        = string
}

variable "environment" {
  description = "Environment name (prod/pre-prod)"
  type        = string
}
