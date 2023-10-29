resource "alicloud_security_group" "rds-sg" {
  name        = "${var.env_name}-${var.project}-rds-sg"
  description = "${var.env_name}-${var.project} security group"
  vpc_id = module.vpc.vpc_id
}

resource "alicloud_security_group_rule" "rds-rule" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "1561/1561"
  security_group_id = alicloud_security_group.rds-sg.id
  cidr_ip           = var.vpc_cidr
}