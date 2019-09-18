variable "az" {}
variable "ami" {}
variable "instance_type" {}

variable "key_name" {}

variable "subnet_id" {}

variable "sg_name" {}

variable "cidr_block" {
  default = "0.0.0.0/0"
}

variable "vpc_id" {}