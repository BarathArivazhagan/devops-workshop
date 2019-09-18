provider "aws" {
  region = var.aws_region
}

module "ec2_module" {
  source = "./ec2"
  instance_type = var.instance_type
  key_name = var.key_name
  sg_name = var.sg_name
  subnet_id = module.vpc_module.public_subnet_id
  vpc_id = module.vpc_module.my_vpc_id
  az = module.vpc_module.public_subnet_az
  ami = var.ami
}

module "s3_module" {
  source = "./s3"
  bucket_name = var.bucket_name
}

module "vpc_module" {
  source = "./vpc"
  private_subnet_cidr_block = var.private_subnet_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  vpc_cidr_block = var.vpc_cidr_block
}