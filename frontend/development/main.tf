provider "aws" {
    region = "ap-northeast-2"
}

module "network" {
    source = "../common/network"
    vpc_cidr_block = var.vpc_cidr_block
    env = var.env
    public_subnet_count = var.public_subnet_count
    pulbic_subnet_cidr_block = var.pulbic_subnet_cidr_block
    private_subnet_count = var.private_subnet_count
    private_subnet_cidr_block = var.private_subnet_cidr_block
}