resource "aws_instance" "this" {
  count                  = var.instance_count
  ami                    = "ami-0c2b8ca1dad447f8a" # Amazon Linux 2 (Free Tier, us-east-1)
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index)
  vpc_security_group_ids = var.security_group_ids

  associate_public_ip_address = true

  tags = {
    Name = "poc-${var.env}-instance${count.index + 1}"
  }
}
