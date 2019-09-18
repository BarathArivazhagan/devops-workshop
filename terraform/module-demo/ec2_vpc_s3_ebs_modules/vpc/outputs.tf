output "my_vpc_id" {
  value = aws_vpc.demo_vpc.id
}

output "public_subnet_az" {
  value = aws_subnet.public_subnet.availability_zone
}


output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}
