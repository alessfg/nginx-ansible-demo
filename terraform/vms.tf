resource "aws_instance" "debian_12" {
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
    Name  = "debian_12"
    Owner = var.owner
    user  = "admin"
    type  = "ansible"
  }
}

resource "aws_instance" "ubuntu_22" {
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
    Name  = "ubuntu_22"
    Owner = var.owner
    user  = "ubuntu"
    type  = "ansible"
  }
}

resource "aws_instance" "rhel_9" {
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
    Name  = "rhel_9"
    Owner = var.key_name
    user  = "ec2-user"
    type  = "ansible"
  }
}
