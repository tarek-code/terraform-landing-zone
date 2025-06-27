resource "aws_s3_bucket" "flow_logs_bucket" {
  bucket = var.s3_bucket_name
  tags = {
    Name        = var.s3_bucket_name
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "vpc_log_group" {
  name              = "/aws/vpc/${var.environment}/flow-logs"
  retention_in_days = 7

  tags = {
    Name        = "poc-${var.environment}-logs"
    Environment = var.environment
  }
}

resource "aws_iam_role" "vpc_flow_logs_role" {
  name = "poc-${var.environment}-flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "vpc_flow_logs_policy" {
  role       = aws_iam_role.vpc_flow_logs_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_flow_log" "vpc_flow_log" {
  log_destination_type = "cloud-watch-logs"
  log_group_name       = aws_cloudwatch_log_group.vpc_log_group.name
  iam_role_arn         = aws_iam_role.vpc_flow_logs_role.arn
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id
}

resource "aws_flow_log" "vpc_flow_log_s3" {
  log_destination      = aws_s3_bucket.flow_logs_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id
}
