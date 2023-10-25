module "vpc" {
  source  = "alibaba/vpc/alicloud"

  create            = true
  vpc_name          = "prod-terrababa-vpc"
  vpc_cidr          = "10.5.0.0/16"
  #resource_group_id = "rg-acfmwvvtg5o****"

  availability_zones = ["ap-southeast-6a"]
  vswitch_cidrs      = [var.public_subnet_cidr_1, var.public_subnet_cidr_2, var.private_subnet_cidr_1, var.private_subnet_cidr_2]

  vpc_tags = {
    Environment = var.env_name
    Name        = "prod-terrababa-vpc"
  }

  vswitch_tags = {
    Project  = var.project
    #Endpoint = "true"
  }

  #destination_cidrs = var.destination_cidrs
  #nexthop_ids       = var.server_ids
}