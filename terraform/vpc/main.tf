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

resource "aws_subnet" "public_subnet1" {
  cidr_block = "10.0.0.0/24"
  vpc_id = "${aws_vpc.demo_vpc.id}"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.stack_name}-public-subnet-us-east-2a"
  }

}

resource "aws_subnet" "public_subnet2" {
  cidr_block = "10.0.1.0/24"
  vpc_id = "${aws_vpc.demo_vpc.id}"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.stack_name}-public-subnet-us-east-2b"
  }

}

resource "aws_subnet" "private_subnet1" {
  cidr_block = "10.0.2.0/24"
  vpc_id = "${aws_vpc.demo_vpc.id}"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.stack_name}-private-subnet-us-east-2a"
  }

}


resource "aws_subnet" "private_subnet2" {
  cidr_block = "10.0.3.0/24"
  vpc_id = "${aws_vpc.demo_vpc.id}"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.stack_name}-private-subnet-us-east-2b"
  }

}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.demo_vpc.id}"
  tags= {
    Name= "${var.stack_name}-ig"
  }

}

resource "aws_route_table" "private_table" {
  vpc_id = "${aws_vpc.demo_vpc.id}"
  tags = {
    Name = "${var.stack_name}-private-table"
  }

}


resource "aws_route_table" "public_table" {
  vpc_id = "${aws_vpc.demo_vpc.id}"
  tags = {
    Name = "${var.stack_name}-public-table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }
}

resource "aws_route_table_association" "private_table_association_private1" {
  route_table_id = "${aws_route_table.private_table.id}"
  subnet_id = "${aws_subnet.private_subnet1.id}"
}

resource "aws_route_table_association" "private_table_association_private2" {
  route_table_id = "${aws_route_table.private_table.id}"
  subnet_id = "${aws_subnet.private_subnet2.id}"
}


resource "aws_route_table_association" "public_table_association_public1" {
  route_table_id = "${aws_route_table.public_table.id}"
  subnet_id = "${aws_subnet.public_subnet1.id}"
}

resource "aws_route_table_association" "public_table_association_public2" {
  route_table_id = "${aws_route_table.public_table.id}"
  subnet_id = "${aws_subnet.public_subnet2.id}"
}
















