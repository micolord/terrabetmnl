resource "alicloud_security_group" "fe-sg" {
  name        = "${var.env_name}-${var.project}-fe-sg"
  description = "${var.env_name}-${var.project} security group"
  vpc_id = module.vpc.vpc_id
}

resource "alicloud_security_group_rule" "fe-https" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  security_group_id = alicloud_security_group.fe-sg.id
  cidr_ip           = var.vpc_cidr
}

resource "alicloud_security_group_rule" "fe-https-egress" {
  type              = "egress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  security_group_id = alicloud_security_group.bo-sg.id
  cidr_ip           = var.vpc_cidr
}