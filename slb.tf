data "alicloud_alb_zones" "default" {}

resource "alicloud_alb_load_balancer" "default" {
  vpc_id                 = module.vpc.vpc_id
  address_type           = "Intranet"
  address_allocated_mode = "Fixed"
  load_balancer_name     = "${var.env_name}-${var.project}-intra-lb"
  load_balancer_edition  = "WAF Enabled"
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  tags = {
    name = "${var.env_name}-${var.project}-intra-lb"
  }
  zone_mappings {
    vswitch_id = module.vpc.vswitch_ids[0]
    zone_id    = data.alicloud_alb_zones.default.zones.0.id
  }
  modification_protection_config {
    status = "NonProtection"
  }
}