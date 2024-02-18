resource "alicloud_security_group" "jobproc-sg" {
  name        = "${var.env_name}-${var.project}-jobproc-sg"
  description = "${var.env_name}-${var.project} security group"
  vpc_id = module.vpc.vpc_id
}

resource "alicloud_security_group_rule" "jobproc-https" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  security_group_id = alicloud_security_group.jobproc-sg.id
  cidr_ip           = var.vpc_cidr
}

resource "alicloud_security_group_rule" "jobproc-https-egress" {
  type              = "egress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  security_group_id = alicloud_security_group.jobproc-sg.id
  cidr_ip           = var.vpc_cidr
}

resource "alicloud_security_group_rule" "jobproc-udp-dns-egress" {
  type              = "egress"
  ip_protocol       = "udp"
  port_range        = "53/53"
  security_group_id = alicloud_security_group.jobproc-sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "jobproc-tcp-dns-egress" {
  type              = "egress"
  ip_protocol       = "tcp"
  port_range        = "53/53"
  security_group_id = alicloud_security_group.jobproc-sg.id
  cidr_ip           = "0.0.0.0/0"
}