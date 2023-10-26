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
  vpc_id           = module.vpc.vpc_id
  nat_gateway_name = "${var.env_name}-${var.project}-ingw"
  payment_type     = "PayAsYouGo"
  vswitch_id       = module.vpc.vswitch_ids[1]
  nat_type         = "Enhanced"
}

resource "alicloud_eip" "int_nat_eip1" {
  bandwidth            = "10"
  internet_charge_type = "PayByBandwidth"
}

resource "alicloud_eip" "snat_eip1" {
  bandwidth            = "10"
  internet_charge_type = "PayByBandwidth"
}

resource "alicloud_eip_association" "int_nat_assoc1" {
  allocation_id = alicloud_eip.int_nat_eip1.id
  instance_type = "Nat"
  instance_id   = alicloud_nat_gateway.int_nat_gw1.id
}

resource "alicloud_snat_entry" "int_nat_snat1" {
  snat_table_id     = alicloud_nat_gateway.int_nat_gw1.snat_table_ids
  source_vswitch_id = module.vpc.vswitch_ids[1]
  snat_ip           = alicloud_eip.snat_eip1.ip_address
}