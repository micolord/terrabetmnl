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

resource "alicloud_alb_rule" "fe_rule" {
  depends_on  = [alicloud_alb_listener.default_80]
  rule_name   = "${var.env_name}-${var.project}-fe-rule"
  listener_id = alicloud_alb_listener.default_80.id
  priority    = "2"
  rule_conditions {
    type = "Host"
    host_config {
      values = ["tf-example-fe.com"]
    }
  }

  rule_actions {
    forward_group_config {
      server_group_tuples {
        server_group_id = alicloud_alb_server_group.fe_grp.id
      }
    }
    order = "1"
    type  = "ForwardGroup"
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
    #health_check_http_version = "HTTP1.1"
    health_check_interval     = "2"
    #health_check_method       = "HEAD"
    #health_check_path         = "/tf-example"
    #health_check_host         = "tfexample.com"
    health_check_protocol     = "TCP"
    health_check_timeout      = 5
    healthy_threshold         = 3
    unhealthy_threshold       = 3
  }
  sticky_session_config {
    sticky_session_enabled = false
    cookie                 = "tf-example"
    sticky_session_type    = "Server"
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

resource "alicloud_alb_rule" "bo_rule" {
  depends_on  = [alicloud_alb_listener.default_80]
  rule_name   = "${var.env_name}-${var.project}-bo-rule"
  listener_id = alicloud_alb_listener.default_80.id
  priority    = "3"
  rule_conditions {
    type = "Host"
    host_config {
      values = ["tf-example-bo.com"]
    }
  }

  rule_actions {
    forward_group_config {
      server_group_tuples {
        server_group_id = alicloud_alb_server_group.bo_grp.id
      }
    }
    order = "1"
    type  = "ForwardGroup"
  }
}


resource "alicloud_alb_server_group" "bo_grp" {
  protocol          = "HTTP"
  vpc_id            = module.vpc.vpc_id
  server_group_name = "${var.env_name}-${var.project}-bo-grp"
  health_check_config {
    health_check_connect_port = "80"
    health_check_enabled      = true
    health_check_codes        = ["http_2xx", "http_3xx"]
    #health_check_http_version = "HTTP1.1"
    health_check_interval     = "2"
    #health_check_method       = "HEAD"
    #health_check_path         = "/tf-example"
    #health_check_host         = "tfexample.com"
    health_check_protocol     = "TCP"
    health_check_timeout      = 5
    healthy_threshold         = 3
    unhealthy_threshold       = 3
  }
  sticky_session_config {
    sticky_session_enabled = false
    cookie                 = "tf-example"
    sticky_session_type    = "Server"
  }
  servers {
    description = "${var.env_name}-${var.project}-bo-1"
    port        = 80
    server_id   = alicloud_instance.bo_ecs_instance_1.id
    server_type = "Ecs"
  }
  servers {
    description = "${var.env_name}-${var.project}-bo-2"
    port        = 80
    server_id   = alicloud_instance.bo_ecs_instance_2.id
    server_type = "Ecs"
  }
}

resource "alicloud_alb_rule" "jobproc_rule" {
  depends_on  = [alicloud_alb_listener.default_80]
  rule_name   = "${var.env_name}-${var.project}-jobproc-rule"
  listener_id = alicloud_alb_listener.default_80.id
  priority    = "4"
  rule_conditions {
    type = "Host"
    host_config {
      values = ["tf-example-jobproc.com"]
    }
  }

  rule_actions {
    forward_group_config {
      server_group_tuples {
        server_group_id = alicloud_alb_server_group.jobproc_grp.id
      }
    }
    order = "1"
    type  = "ForwardGroup"
  }
}


resource "alicloud_alb_server_group" "jobproc_grp" {
  protocol          = "HTTP"
  vpc_id            = module.vpc.vpc_id
  server_group_name = "${var.env_name}-${var.project}-jobproc-grp"
  health_check_config {
    health_check_connect_port = "80"
    health_check_enabled      = true
    health_check_codes        = ["http_2xx", "http_3xx"]
    #health_check_http_version = "HTTP1.1"
    health_check_interval     = "2"
    #health_check_method       = "HEAD"
    #health_check_path         = "/tf-example"
    #health_check_host         = "tfexample.com"
    health_check_protocol     = "TCP"
    health_check_timeout      = 5
    healthy_threshold         = 3
    unhealthy_threshold       = 3
  }
  sticky_session_config {
    sticky_session_enabled = false
    cookie                 = "tf-example"
    sticky_session_type    = "Server"
  }
  servers {
    description = "${var.env_name}-${var.project}-jobproc-1"
    port        = 80
    server_id   = alicloud_instance.jobproc_ecs_instance_1.id
    server_type = "Ecs"
  }
  servers {
    description = "${var.env_name}-${var.project}-jobproc-2"
    port        = 80
    server_id   = alicloud_instance.jobproc_ecs_instance_2.id
    server_type = "Ecs"
  }
}

resource "alicloud_alb_rule" "socket_rule" {
  depends_on  = [alicloud_alb_listener.default_80]
  rule_name   = "${var.env_name}-${var.project}-socket-rule"
  listener_id = alicloud_alb_listener.default_80.id
  priority    = "5"
  rule_conditions {
    type = "Host"
    host_config {
      values = ["tf-example-socket.com"]
    }
  }

  rule_actions {
    forward_group_config {
      server_group_tuples {
        server_group_id = alicloud_alb_server_group.socket_grp.id
      }
    }
    order = "1"
    type  = "ForwardGroup"
  }
}


resource "alicloud_alb_server_group" "socket_grp" {
  protocol          = "HTTP"
  vpc_id            = module.vpc.vpc_id
  server_group_name = "${var.env_name}-${var.project}-socket-grp"
  health_check_config {
    health_check_connect_port = "80"
    health_check_enabled      = true
    health_check_codes        = ["http_2xx", "http_3xx"]
    #health_check_http_version = "HTTP1.1"
    health_check_interval     = "2"
    #health_check_method       = "HEAD"
    #health_check_path         = "/tf-example"
    #health_check_host         = "tfexample.com"
    health_check_protocol     = "TCP"
    health_check_timeout      = 5
    healthy_threshold         = 3
    unhealthy_threshold       = 3
  }
  sticky_session_config {
    sticky_session_enabled = false
    cookie                 = "tf-example"
    sticky_session_type    = "Server"
  }
  servers {
    description = "${var.env_name}-${var.project}-socket-1"
    port        = 80
    server_id   = alicloud_instance.socket_ecs_instance_1.id
    server_type = "Ecs"
  }
  servers {
    description = "${var.env_name}-${var.project}-socket-2"
    port        = 80
    server_id   = alicloud_instance.socket_ecs_instance_2.id
    server_type = "Ecs"
  }
}