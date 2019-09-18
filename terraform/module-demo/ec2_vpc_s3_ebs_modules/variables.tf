variable "ami" {}

variable "vpc_cidr_block" {}
variable "public_subnet_cidr_block" {}
variable "private_subnet_cidr_block" {}

variable "instance_type" {}

variable "key_name" {}

variable "aws_region" {}

variable "sg_name" {}

variable "cidr_block" {
  default = "0.0.0.0/0"
}


variable "bucket_name" {}