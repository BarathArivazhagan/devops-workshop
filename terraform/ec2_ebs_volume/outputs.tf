## terraform outputs

output "ec2_instance_id" {
  value = aws_instance.demo_instance.id
}

output "my_sg_id" {
  value = aws_security_group.ec2_sg.id
}