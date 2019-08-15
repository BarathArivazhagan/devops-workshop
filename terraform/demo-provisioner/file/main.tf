provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "ec2_instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name  = var.key_name
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnet_id



}

resource "aws_instance" "ec2_instance1" {
  ami = var.ami
  instance_type = var.instance_type
  key_name  = var.key_name
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnet_id
 depends_on = [aws_instance.ec2_instance]


}






# variables


variable "ami" {

}

variable "instance_type" {
  default = "t2.micro"
}
variable "key_name" {}
variable "subnet_id" {}
variable "sg_id" {}
variable "aws_region" {
  default = "us-east-2"
}


