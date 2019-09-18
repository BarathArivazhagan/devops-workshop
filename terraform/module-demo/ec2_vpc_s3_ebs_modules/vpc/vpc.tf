resource "aws_vpc" "demo_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "demo-vpc"
  }
}


resource "aws_subnet" "public_subnet" {
  cidr_block = var.public_subnet_cidr_block
  vpc_id = aws_vpc.demo_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}


resource "aws_subnet" "private_subnet" {
  cidr_block = var.private_subnet_cidr_block
  vpc_id = aws_vpc.demo_vpc.id
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_internet_gateway" "demo_ig" {
  tags  = {
    Name = "demo-internet-gateway"
  }
  vpc_id = aws_vpc.demo_vpc.id
}

resource "aws_eip" "demo_elastic_ip" {

  tags = {
    Name = "demo-elastic-ip"
  }
}

resource "aws_nat_gateway" "demo_nat_gateway" {
  allocation_id = aws_eip.demo_elastic_ip.id
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    Name = "demo-nat-gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id =  aws_vpc.demo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_ig.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id =  aws_vpc.demo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demo_nat_gateway.id
  }
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.public_subnet.id
}

resource "aws_route_table_association" "private_route_table_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.private_subnet.id
}





