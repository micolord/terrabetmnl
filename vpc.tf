module "vpc" {
  source  = "alibaba/vpc/alicloud"

  create            = true
  vpc_name          = "${var.env_name}-${var.project}-vpc"
  vpc_cidr          = var.vpc_cidr

  availability_zones = [var.az_a, var.az_b]
  vswitch_cidrs      = [var.priv_a, var.priv_b, var.priv_c, var.priv_d]

  vpc_tags = {
    Environment = var.env_name
    Name        = "${var.env_name}-${var.project}-vpc"
  }

  vswitch_tags = {
    Environment  = var.env_name
  }
}

/*
resource "alibabacloudstack_route_table" "rtb_2" {
  vpc_id      = "${alibabacloudstack_vpc.foo.id}"
  name        = "${var.env_name}-${var.project}-rtb-custom"
  description = "Custom RTB"
}

resource "alibabacloudstack_route_entry" "rtb_2_nat_entry" {
  route_table_id        = alibabacloudstack_vpc.rtb_2.route_table_id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "NatGateway"
  nexthop_id            = alibabacloudstack_instance.foo.id
}

resource "alibabacloudstack_route_table_attachment" "foo" {
  vswitch_id     = module.vpc.vswitch_ids[2]
  route_table_id = alibabacloudstack_route_table.rtb_2.id
}
*/

resource "alicloud_nat_gateway" "int_nat_gw1" {
  vpc_id           = module.vpc.vpc_id
  nat_gateway_name = "${var.env_name}-${var.project}-ingw1"
  payment_type     = "PayAsYouGo"
  vswitch_id       = module.vpc.vswitch_ids[1]
  nat_type         = "Enhanced"
}

resource "alicloud_eip_address" "eip_addr_snat1" {
  address_name  = "${var.env_name}-${var.project}-eipaddr1"
}

resource "alicloud_eip_association" "int_nat_assoc1" {
  allocation_id = alicloud_eip_address.eip_addr_snat1.id
  instance_type = "Nat"
  instance_id   = alicloud_nat_gateway.int_nat_gw1.id
}

resource "alicloud_snat_entry" "int_nat_snat1" {
  snat_table_id     = alicloud_nat_gateway.int_nat_gw1.snat_table_ids
  source_vswitch_id = module.vpc.vswitch_ids[1]
  snat_ip           = alicloud_eip_address.eip_addr_snat1.ip_address
}


resource "alicloud_nat_gateway" "int_nat_gw2" {
  vpc_id           = module.vpc.vpc_id
  nat_gateway_name = "${var.env_name}-${var.project}-ingw2"
  payment_type     = "PayAsYouGo"
  vswitch_id       = module.vpc.vswitch_ids[2]
  nat_type         = "Enhanced"
}

resource "alicloud_eip_address" "eip_addr_snat2" {
  address_name  = "${var.env_name}-${var.project}-eipaddr2"
}

resource "alicloud_eip_association" "int_nat_assoc2" {
  allocation_id = alicloud_eip_address.eip_addr_snat2.id
  instance_type = "Nat"
  instance_id   = alicloud_nat_gateway.int_nat_gw2.id
}

resource "alicloud_snat_entry" "int_nat_snat2" {
  snat_table_id     = alicloud_nat_gateway.int_nat_gw2.snat_table_ids
  source_vswitch_id = module.vpc.vswitch_ids[2]
  snat_ip           = alicloud_eip_address.eip_addr_snat2.ip_address
}