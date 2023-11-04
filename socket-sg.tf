resource "alicloud_security_group" "socket-sg" {
  name        = "${var.env_name}-${var.project}-socket-sg"
  description = "${var.env_name}-${var.project} security group"
  vpc_id = module.vpc.vpc_id
}

resource "alicloud_security_group_rule" "socket-https" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  security_group_id = alicloud_security_group.socket-sg.id
  cidr_ip           = var.vpc_cidr
}