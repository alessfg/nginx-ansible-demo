variable "region" {
  description = "Your target AWS region"
  default     = "us-west-1"
  type        = string
}

variable "ami" {
  description = "AMI IDs to be deployed in AWS"
  default = {
    debian_9 = {
      ami_id = "ami-0e18a7cf6bec77ac9"
      deploy = true
    }
    ubuntu_18 = {
      ami_id = "ami-03fac5402e10ea93b"
      deploy = true
    }
    centos_7 = {
      ami_id = "ami-098f55b4287a885ba"
      deploy = true
    }
    rhel_7 = {
      ami_id = "ami-07d8d14365439bc6e"
      deploy = true
    }
  }
  type = map(object({
    ami_id = string
    deploy = bool
  }))
}

variable "machine_type" {
  description = "The machine type of the AWS instance"
  default     = "t2.medium"
  type        = string
}

variable "key_name" {
  description = "The key name used to ssh into your AWS instance"
  default     = "alessandro"
  type        = string
}
