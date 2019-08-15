provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "ec2_instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name  = var.key_name
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnet_id
  user_data = data.template_file.test.rendered



}

resource "null_resource" "test" {

  triggers {
    public_dns = aws_instance.ec2_instance.public_dns

  }

  provisioner "remote-exec" {
    inline = [data.template_file.test.rendered]
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = ""
    host = aws_instance.ec2_instance.public_dns
  }
}

resource "aws_instance" "ec2_instance1" {
  ami = var.ami
  instance_type = var.instance_type
  key_name  = var.key_name
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnet_id




}

data "template_file" "test" {

  template = "echo ${aws_instance.ec2_instance1.private_ip} > inventory.txt"
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


