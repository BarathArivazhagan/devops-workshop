provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.stack_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {

  count = 2
  cidr_block = cidrsubnet(aws_vpc.demo_vpc.cidr_block,8,count.index)
  vpc_id = "${aws_vpc.demo_vpc.id}"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = join("-",[var.stack_name,"public-subnet-us-east-2a"])
  }

}

// public subnet 0
// public subnet 1

resource "aws_instance" "ec2_instance" {

  count = length(aws_subnet.public_subnet.*.id)
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id = element(aws_subnet.public_subnet.*.id,count.index)
  key_name = "${var.key_name}"
  security_groups = ["${var.sg_id}"]

  tags = {
    Name = "terraform-ec2-demo-${count.index + 2 }"
  }

}

