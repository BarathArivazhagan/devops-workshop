provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "ec2_instance" {

  count = var.count == "prod" ? 2 : 1
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  key_name = "${var.key_name}"
  security_groups = ["${var.sg_id}"]

  tags = {
    Name = "terraform-ec2-demo-${count.index}"
  }

}

