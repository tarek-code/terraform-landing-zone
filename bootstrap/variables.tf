variable "bucket_name" {
  type        = string
  description = "S3 bucket name for terraform state"
}

variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name for terraform state lock"
}
