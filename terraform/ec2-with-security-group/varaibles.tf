variable "aws_region" {
  default = "us-east-1"
  type = "string"
}
variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

variable "ami" {
  type = "string"
  description = "ami id"
}

variable "instance_type" {
  type = "string"
  default = "t2.micro"
}

variable "subnet_id" {
  type = "string"
  description = "subnet id where ec2 instance to be hosted"
}

variable "key_name" {
  type = "string"
}

variable "sg_id" {
  type = "string"
}

variable "vpc_id" {}

# variable "variable_name"{

#}

variable "azs" {
  type = "map"
  default = {
    us-east-1 = ["us-east-1a","us-east-1b"]
    us-east-2 = "us-east-2a"
  }
}

variable "sgs" {
  type = "list"
  default = ["a","b"]
}