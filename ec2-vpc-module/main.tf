provider "aws" {
  region = var.aws_region

}



module "ec2" {
  source = "./ec2"
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = module.vpc.public_subnet_id
  key_name = var.key_name
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "./vpc"
  cidr_block = var.cidr_block
}