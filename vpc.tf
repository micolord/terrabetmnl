module "vpc" {
  source  = "alibaba/vpc/alicloud"

  create            = true
  vpc_name          = "${var.env_name}-${var.project}-vpc"
  vpc_cidr          = var.vpc_cidr

  availability_zones = [var.az_a]
  vswitch_cidrs      = [var.priv_a, var.priv_b, var.priv_c, var.pub_a]

  vpc_tags = {
    Environment = var.env_name
    Name        = "${var.env_name}-${var.project}-vpc"
  }

  vswitch_tags = {
    Environment  = var.env_name
  }
}

module "nat-gateway1" {
  source = "terraform-alicloud-modules/nat-gateway/alicloud"
  region = var.region

  create = true
  vpc_id = module.vpc.vpc_id
  name   = "${var.env_name}-${var.project}-natgw1"
  vswitch_id = module.vpc.vswitch_ids[1]

  // Create eip and bind them with nat gateway
  create_eip    = true
  number_of_eip = 1
  eip_name      = "${var.env_name}-${var.project}-eip1"
}

module "nat-gateway2" {
  source = "terraform-alicloud-modules/nat-gateway/alicloud"
  region = var.region

  create = true
  vpc_id = module.vpc.vpc_id
  name   = "${var.env_name}-${var.project}-natgw2"
  vswitch_id = module.vpc.vswitch_ids[2]

  // Create eip and bind them with nat gateway
  create_eip    = true
  number_of_eip = 1
  eip_name      = "${var.env_name}-${var.project}-eip2"
}