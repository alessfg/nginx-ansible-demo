variable "region" {
  description = "Your target AWS region"
  default     = "us-west-1"
  type        = string
}

variable "machine_type" {
  description = "The machine type of the AWS instance"
  default     = "t2.medium"
  type        = string
}

variable "key_name" {
  description = "The key name used to ssh into your AWS instance"
  # default     = "johndoe"
  type = string
}

variable "owner" {
  description = "Owner of resources"
  default     = "ansible-demo"
  type        = string
}

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-11-amd64-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["136693071363"]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"]
}

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS ENA*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["461800378586"]
}

data "aws_ami" "rhel" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-8.8.0_HVM-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["309956199498"]
}
