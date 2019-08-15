provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# ec2 instance
resource "aws_instance" "ec2_instance" {

  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  key_name = "${var.key_name}"
  security_groups = aws_security_group.sg.id
  iam_instance_profile = "kops-role"
  tags = {
    Name = "terraform-ec2-demo-sg"
  }
  root_block_device {
    volume_size = 12
    volume_type = "gp2"
  }
  ebs_block_device {
    device_name = ""
    volume_size = "12"
    volume_type = "gp2"
  }

}


# sg
resource "aws_security_group" "sg" {
  name = "ec2-demo-sg"
  description = "Allow all traffic"
  vpc_id = "${var.vpc_id}"
  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ec2-demo-sg"
  }

}



