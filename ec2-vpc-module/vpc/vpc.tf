
resource "aws_vpc" "vpc" {
  cidr_block =  var.cidr_block
}

resource "aws_subnet" "public_subnet" {
  cidr_block = "11.0.0.0/24"
  vpc_id = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  cidr_block = "11.0.1.0/24"
  vpc_id = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = false
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}