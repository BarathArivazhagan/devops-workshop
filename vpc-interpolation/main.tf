provider "aws" {
  region = var.aws_region

}

data "aws_availability_zones" "azs"{
  state = "available"
}


resource "aws_vpc" "demo_vpc" {
  count = length(data.aws_availability_zones.azs.names)
  cidr_block = var.cidr_blocks[count.index]
  tags = {
    Name = "demo-vpc-${count.index}"
  }
}
# US EAST2 , 2a,2b,2c us-east-1 1a,1b,1c,1d,1d,1e
resource "aws_subnet" "subnets" {
  count = 2
  cidr_block = cidrsubnet(aws_vpc.demo_vpc[count.index].cidr_block,8,count.index)
  vpc_id = "${aws_vpc.demo_vpc.id}"
  availability_zone = data.aws_availability_zones.azs.names[count.index]
}



resource "aws_instance" "ec2_instance" {
  count = 2
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.subnets[count.index].id # aws_subnet.subnets[0].id aws_subnet.subnets[1].id
  security_groups = "${var.sg_id}"
  key_name = var.key_name
  tags = {
    Name = "terraform-ec2-demo"
    Training = "hope-tutors"
  }

}
