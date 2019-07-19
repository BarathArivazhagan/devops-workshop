provider "aws" {
  region = var.aws_region

}


resource "aws_instance" "ec2_instance" {
  count = 2
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  security_groups = "${var.sg_id}"
  key_name = var.key_name
  tags = {
    Name = "terraform-ec2-demo"
    Training = "hope-tutors"
  }

}

