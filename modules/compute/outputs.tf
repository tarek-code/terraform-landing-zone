output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.this[*].id
}

output "public_ips" {
  description = "Public IPs of EC2 instances"
  value       = aws_instance.this[*].public_ip
}
