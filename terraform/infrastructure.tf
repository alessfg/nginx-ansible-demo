resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    name   = "aws-vpc-ansible"
    author = var.key_name
  }
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    name   = "aws-subnet-ansible"
    author = var.key_name
  }
}

resource "aws_security_group" "main" {
  name        = "aws-sec-grp"
  description = "Security group for AWS NLB"
  vpc_id      = aws_vpc.main.id
  tags = {
    name   = "aws-sec-grp-ansible"
    author = var.key_name
  }

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    name   = "aws-gtwy-ansible"
    author = var.key_name
  }
}

resource "aws_route" "main" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}