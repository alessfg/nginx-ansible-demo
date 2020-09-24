resource "aws_instance" "debian_9_13" {
  count         = 1
  ami           = "ami-0e18a7cf6bec77ac9"
  instance_type = var.machine_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.main.id
  ]
  subnet_id = aws_subnet.main.id
  user_data = <<EOF
#! /bin/bash
apt update
apt install -y python3 python3-apt
EOF
  tags = {
    Name   = "debian_9_13"
    user   = "admin"
    author = var.key_name
    type   = "ansible"
  }
}

resource "aws_instance" "ubuntu_18" {
  count         = 1
  ami           = "ami-03fac5402e10ea93b"
  instance_type = var.machine_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.main.id
  ]
  subnet_id = aws_subnet.main.id
  user_data = <<EOF
#! /bin/bash
apt update
apt install -y python3 python3-apt
EOF
  tags = {
    Name   = "ubuntu_18"
    user   = "ubuntu"
    author = var.key_name
    type   = "ansible"
  }
}

resource "aws_instance" "centos_7" {
  count         = 1
  ami           = "ami-098f55b4287a885ba"
  instance_type = var.machine_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.main.id
  ]
  subnet_id = aws_subnet.main.id
  user_data = <<EOF
#! /bin/bash
yum update
yum install -y python3
EOF
  tags = {
    Name   = "centos-7"
    user   = "centos"
    author = var.key_name
    type   = "ansible"
  }
}

resource "aws_instance" "rhel_7_7" {
  count         = 1
  ami           = "ami-07d8d14365439bc6e"
  instance_type = var.machine_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.main.id
  ]
  subnet_id = aws_subnet.main.id
  user_data = <<EOF
#! /bin/bash
yum update
yum install -y python3
EOF
  tags = {
    Name   = "rhel_7_7"
    user   = "ec2-user"
    author = var.key_name
    type   = "ansible"
  }
}
