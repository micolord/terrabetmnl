resource "alicloud_slb_load_balancer" "load_balancer" {
  load_balancer_name = "${var.env_name}-${var.project}-intra-lb"
  address_type       = "intranet"
  vswitch_id         = module.vpc.vswitch_ids[0]
  tags = {
    info = "create for intranet"
    name = "${var.env_name}-${var.project}-intra-lb"
  }
}