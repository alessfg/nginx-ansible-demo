variable "region" {
  description = "Your target AWS region"
  default     = "us-west-1"
  type        = string
}
variable "ami" {
  description = "AMI IDs to be deployed in AWS"
  default = {
    debian_9  = "ami-0e18a7cf6bec77ac9"
    ubuntu_18 = "ami-03fac5402e10ea93b"
    centos_7  = "ami-098f55b4287a885ba"
    rhel_7    = "ami-07d8d14365439bc6e"
  }
  type = map(string)
}

variable "machine_type" {
  description = "The machine type of the AWS instance"
  default     = "t2.medium"
  type        = string
}

variable "key_name" {
  description = "The key name used to ssh into your AWS instance"
  default     = ""
  type        = string
}
