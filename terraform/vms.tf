resource "aws_instance" "debian_10" {
  ami           = data.aws_ami.debian.id
  instance_type = var.machine_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.main.id
  ]
  subnet_id = aws_subnet.main.id
  user_data = <<EOF
#! /bin/bash
apt update
apt install -y python3 python3-apt python-apt
EOF
  tags = {
    Name   = "debian_10"
    user   = "admin"
    author = var.key_name
    type   = "ansible"
  }
}

resource "aws_instance" "ubuntu_18" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.machine_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.main.id
  ]
  subnet_id = aws_subnet.main.id
  user_data = <<EOF
#! /bin/bash
apt update
apt install -y python3 python3-apt python-apt
EOF
  tags = {
    Name   = "ubuntu_18"
    user   = "ubuntu"
    author = var.key_name
    type   = "ansible"
  }
}

resource "aws_instance" "centos_7" {
  ami           = data.aws_ami.centos.id
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

resource "aws_instance" "rhel_7" {
  ami           = data.aws_ami.rhel.id
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
    Name   = "rhel_7"
    user   = "ec2-user"
    author = var.key_name
    type   = "ansible"
  }
}
