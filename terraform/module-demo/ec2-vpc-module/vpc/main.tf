

resource "aws_vpc" "demo_vpc" {
  cidr_block = var.cidr_block

}

resource "aws_subnet" "public_subnet" {
  cidr_block = "10.0.0.0/24"
  vpc_id = "${aws_vpc.demo_vpc.id}"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true


}

resource "aws_subnet" "private_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = "${aws_vpc.demo_vpc.id}"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true


}

output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}