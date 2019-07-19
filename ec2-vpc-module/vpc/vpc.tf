

data "aws_availability_zones" "azs"{
  state = "available"
}



resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "public_subnet" {
  count= 3
  cidr_block =  cidrsubnet(var.cidr_block,8,count.index)
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.azs.names[1]
}

resource "aws_subnet" "private_subnet" {
  cidr_block = cidrsubnet(var.cidr_block,8,1)
  vpc_id = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.azs.names[0]
  map_public_ip_on_launch = false
}

output "vpc_id" {
  value = aws_vpc.vpc
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}