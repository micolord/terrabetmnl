data "alicloud_db_zones" "default" {}

resource "alicloud_db_instance" "default" {
  #engine                   = "MariaDB"
  #engine_version           = "10.3"
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_type            = "mysql.x4.large.2c"
  instance_storage         = "200"
  instance_name            = "${var.env_name}-${var.project}-master-rds"
  zone_id                  = data.alicloud_db_zones.default.zones.0.id
  #zone_id                  = "zone-a"
  vswitch_id               = module.vpc.vswitch_ids[3]
  monitoring_period        = "60"
  db_instance_storage_type = "cloud_essd"
  #security_group_ids       = [alicloud_security_group.rds-sg.id]
  security_ips             = [var.vpc_cidr]
  category                 = "Basic"
  #master_username          = "apsarauser"
  #master_user_password     = "dynamic_random_password"
}

resource "alicloud_db_readonly_instance" "default" {
  zone_id               = data.alicloud_db_zones.default.zones.0.id
  master_db_instance_id = alicloud_db_instance.default.id
  engine_version        = alicloud_db_instance.default.engine_version
  instance_storage      = alicloud_db_instance.default.instance_storage
  instance_type         = alicloud_db_instance.default.instance_type
  instance_name         = "${var.env_name}-${var.project}-readonly"
  vswitch_id            = module.vpc.vswitch_ids[3]
}