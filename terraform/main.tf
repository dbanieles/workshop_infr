terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.61.0"
    }
  }
}

module "workshop_vpc" {
    source               = "./modules/aws-vpc"

    vpc_cidr_block       = var.custom_vpc
    vpc_instance_tenancy = var.instance_tenancy
    availability_zones   = data.aws_availability_zones.azs
    iam_role_arn         = data.aws_iam_role.iam_role.arn
}

module "workshop_security_group" {
    source = "./modules/aws-security-group"

    sg_name = "CustomSG"
    vpc_id = module.workshop_vpc.vpc_id
}

module "workshop_ec2_instances" {
    source = "./modules/aws-ec2"

    ami_id            = var.ami_id
    instance_type     = var.instance_type
    public_subnet_id  = module.workshop_vpc.public_subnet_id
    security_group_id = module.workshop_security_group.security_group_id
    ssh_private_key   = var.ssh_private_key
    iam_role_name     = data.aws_iam_role.iam_role.name
}

module "application_load_balancer" {
    source              = "./modules/aws-load-balancer"

    vpc_id              = module.workshop_vpc.vpc_id

    ec2_instances_id    = module.workshop_ec2_instances.ec2_instances_id
    lb_target_group_arn = ""

    load_balancer_name  = "ALB"
    security_group_id   = module.workshop_security_group.security_group_id
    public_subnet_id    = module.workshop_vpc.public_subnet_id
}