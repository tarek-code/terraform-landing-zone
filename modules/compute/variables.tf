variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch instances in"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "env" {
  description = "Environment name: pre-prod or prod"
  type        = string
}
