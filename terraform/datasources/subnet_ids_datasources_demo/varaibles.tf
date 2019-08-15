variable "aws_region" {
  default = "us-east-1"
  type = "string"
}

variable "ami" {
  type = "string"
  description = "ami id"
}

variable "instance_type" {
  type = "string"
  default = "t2.micro"
}

variable "key_name" {
  type = "string"
}

variable "sg_id" {
  type = "string"
}
