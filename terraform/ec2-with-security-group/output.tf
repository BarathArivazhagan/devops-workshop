

output "my-instance-id" {
  value = "${aws_instance.ec2_instance.id}"
}

output "my-security-group-id" {
  value = "${aws_security_group.sg.id}"
}
output "test" {
  value = ""
}