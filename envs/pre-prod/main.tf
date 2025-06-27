provider "aws" {
  region = "us-east-1"
}

module "network" {
  source              = "../../modules/network"
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidrs = var.public_subnet_cidrs
  env                 = var.env
}
resource "aws_security_group" "ec2_sg" {
  name        = "poc-pre-prod-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.network.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "poc-pre-prod-sg"
  }
}

module "compute" {
  source             = "../../modules/compute"
  env                = "pre-prod"
  instance_count     = 1
  instance_type      = "t2.micro"
  subnet_ids         = module.network.public_subnet_ids
  security_group_ids = [aws_security_group.ec2_sg.id]
}
