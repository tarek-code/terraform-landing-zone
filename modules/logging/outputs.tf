output "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.vpc_flow_logs.name
}

output "s3_log_bucket" {
  description = "The name of the S3 bucket for VPC Flow Logs"
  value       = aws_s3_bucket.log_bucket.bucket
}
