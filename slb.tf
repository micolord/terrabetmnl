data "alicloud_alb_zones" "default" {}

resource "alicloud_alb_load_balancer" "default" {
  vpc_id                 = module.vpc.vpc_id
  address_type           = "Internet"
  address_allocated_mode = "Fixed"
  load_balancer_name     = "${var.env_name}-${var.project}-lb"
  load_balancer_edition  = "StandardWithWaf"
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

resource "alicloud_alb_listener" "default_80" {
  load_balancer_id     = alicloud_alb_load_balancer.default.id
  listener_protocol    = "HTTP"
  listener_port        = 80
  listener_description = "${var.env_name}-${var.project}-80-listener"
  default_actions {
    type = "ForwardGroup"
    forward_group_config {
      server_group_tuples {
        server_group_id = alicloud_alb_server_group.fe_grp.id
      }
    }
  }
}

resource "alicloud_alb_server_group" "fe_grp" {
  protocol          = "HTTP"
  vpc_id            = module.vpc.vpc_id
  server_group_name = "${var.env_name}-${var.project}-fe-grp"
  health_check_config {
    health_check_connect_port = "80"
    health_check_enabled      = true
    health_check_codes        = ["http_2xx", "http_3xx"]
    health_check_http_version = "HTTP1.1"
    health_check_interval     = "2"
    health_check_method       = "HEAD"
    #health_check_path         = "/tf-example"
    health_check_protocol     = "HTTP"
    health_check_timeout      = 5
    healthy_threshold         = 3
    unhealthy_threshold       = 3
  }
  servers {
    description = "${var.env_name}-${var.project}-fe-1"
    port        = 80
    server_id   = alicloud_instance.fe_ecs_instance_1.id
    server_type = "Ecs"
  }
  servers {
    description = "${var.env_name}-${var.project}-fe-2"
    port        = 80
    server_id   = alicloud_instance.fe_ecs_instance_2.id
    server_type = "Ecs"
  }
}

