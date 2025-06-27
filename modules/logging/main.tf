resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = var.log_group_name
  retention_in_days = 7

  tags = {
    Environment = var.environment
    Name        = var.log_group_name
  }
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Environment = var.environment
    Name        = var.s3_bucket_name
  }
}

resource "aws_flow_log" "vpc" {
  log_destination      = aws_s3_bucket.log_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id

  tags = {
    Environment = var.environment
    Name        = "poc-${var.environment}-flowlog"
  }
}
