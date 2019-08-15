provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "ec2_instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name  = var.key_name
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnet_id

  provisioner "remote-exec" {
     inline = ["sudo yum install git -y", "touch /home/ec2-user/login.html"]

  }

  provisioner "local-exec" {
    command = "echo ${self.public_dns} > hosts.txt"
  }

//  provisioner "file" {
//    source=""
//    destination = ""
//  }

  connection {

    host = self.public_dns
    user = "ec2-user"
    type = "ssh"
    private_key = file("private_key")


  }



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
variable "name" {}

variable "vpc_id" {}

