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

resource "alicloud_nat_gateway" "int_nat_gw1" {
  vpc_id        = module.vpc.vpc_id
  specification = "Small"
  nat_gate_name = "${var.env_name}-${var.project}-ingw"
}
