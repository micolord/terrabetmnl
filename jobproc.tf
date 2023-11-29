resource "alicloud_instance" "jobproc_ecs_instance_1" {
  instance_name        = "${var.env_name}-${var.project}-jobproc-1"
  image_id             = data.alicloud_images.ubuntu.ids.0
  instance_type        = "ecs.g7.large"
  security_groups      = [alicloud_security_group.jobproc-sg.id]
  vswitch_id           = module.vpc.vswitch_ids[1]
  password             = "dynamic_random_password"
  system_disk_category = "cloud_essd"
  system_disk_size     = 100
  tags = {
    Name = "${var.env_name}-${var.project}-jobproc"
  }
}

/*
resource "alicloud_instance" "jobproc_ecs_instance_2" {
  instance_name        = "${var.env_name}-${var.project}-jobproc-2"
  image_id             = data.alicloud_images.ubuntu.ids.0
  instance_type        = "ecs.g7.large"
  security_groups      = [alicloud_security_group.jobproc-sg.id]
  vswitch_id           = module.vpc.vswitch_ids[1]
  password             = "dynamic_random_password"
  system_disk_category = "cloud_essd"
  system_disk_size     = 100
  tags = {
    Name = "${var.env_name}-${var.project}-jobproc"
  }

}
*/