resource "alicloud_security_group" "bo-sg" {
  name        = "bo-sg"
  description = "bo-sg security group"
}

resource "alicloud_security_group" "bo-sg-rule" {
  name = "bo-sg-rule"
}
resource "alicloud_security_group_rule" "https" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "443"
  security_group_id = alicloud_security_group.bo-sg.id
  cidr_ip           = var.vpc_cidr
}