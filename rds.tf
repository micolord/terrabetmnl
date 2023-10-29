data "alicloud_db_zones" "example" {
  engine                   = "MariaDB"
  engine_version           = "10.3"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "example" {
  engine                   = "MariaDB"
  engine_version           = "10.3"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
}

resource "alicloud_db_instance" "example" {
  engine                   = "MariaDB"
  engine_version           = "10.3"
  instance_type            = "mariadb.x4.large.2c"
  instance_storage         = "200"
  instance_name            = "${var.env_name}-${var.project}-master-rds"
  vswitch_id               = module.vpc.vswitch_ids[3]
  monitoring_period        = "60"
  db_instance_storage_type = "cloud_essd"
  security_group_ids       = [alicloud_security_group.rds-sg.id]
}