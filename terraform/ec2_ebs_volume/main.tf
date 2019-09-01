provider "aws" {

  region = var.aws_region

}

resource "aws_instance" "demo_instance" {

  ami = var.ami_id
  instance_type =  var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = file("user_data")
  key_name = var.key_name
  tags = {
    Name= "terraform-ec2-instance"
  }

  root_block_device {
    volume_size = 10

  }

}

resource "aws_ebs_volume" "demo_volume" {
  availability_zone = var.az_zone
  size = 1
}

resource "aws_volume_attachment" "ec2_demo" {
  device_name = var.device_name
  instance_id = aws_instance.demo_instance.id
  volume_id =  aws_ebs_volume.demo_volume.id
}

resource "aws_security_group" "ec2_sg" {
  name        = "tdemo_sg_sg_terraform"
  description = "tdemo_sg_sg_terraform"
  vpc_id      = var.vpc_id

  ingress {

    from_port   = 443
    to_port     = 443
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "TCP"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

  }
}

