provider "aws" {
  region = "${var.aws_region}"
}

data aws_availability_zones "azs"{
  state = "available"
}

data "aws_instance" "test"{
  id = "i-09ebfe99def187196"
}

resource "aws_vpc" "demo_vpc" {
  cidr_block = "11.0.0.0/16"
}

resource "aws_subnet" "public_subnets" {
  count = length(data.aws_availability_zones.azs.names)
  cidr_block = cidrsubnet(aws_vpc.demo_vpc.cidr_block,8,count.index)
  vpc_id = aws_vpc.demo_vpc.id
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true
}



resource "aws_subnet" "private_subnets" {
  count = length(data.aws_availability_zones.azs.names)
  cidr_block = cidrsubnet(aws_vpc.demo_vpc.cidr_block,8,count.index + length(data.aws_availability_zones.azs.names))
  vpc_id = aws_vpc.demo_vpc.id
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
}


output "azs" {
  value = data.aws_availability_zones.azs
}

output "instance_subnet" {
  value = data.aws_instance.test.subnet_id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets.*.id
}
