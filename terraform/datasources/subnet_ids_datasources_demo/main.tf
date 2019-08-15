provider "aws" {
  region = var.aws_region
}


data "aws_vpc" "demo_vpc"{
  id = var.vpc_id
}

data "aws_subnet_ids" "demo_ids" {
  vpc_id = data.aws_vpc.demo_vpc.id
}

resource "aws_instance" "ec2_instance" {

  count = 3
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = data.aws_subnet_ids.demo_ids.ids[count.index]
  key_name = var.key_name
  security_groups = [var.sg_id]


  tags = {
    Name = join("-",["ec2-demo",count.index,"instance"])
  }

}

output "subnet_ids" {
  value = data.aws_subnet_ids.demo_ids.ids
}
