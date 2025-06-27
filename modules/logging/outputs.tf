output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.vpc_log_group.name
}

output "s3_log_bucket" {
  value = aws_s3_bucket.flow_logs_bucket.bucket
}
