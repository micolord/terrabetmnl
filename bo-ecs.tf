data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_18.*64"
}

resource "alicloud_instance" "ecs_instance" {
  instance_name        = "${var.env_name}-${var.project}-bo"
  image_id             = data.alicloud_images.ubuntu.ids.0
  instance_type        = "ecs.g7.large"
  security_groups      = [alicloud_security_group.bo-sg.id]
  vswitch_id           = module.vpc.vswitch_ids[1]
  password             = "dynamic_random_password"
  system_disk_category = "cloud_essd"
  system_disk_size     = 100
  tags = {
    Name = "${var.env_name}-${var.project}-bo"
  }
  volume_tags = {
    Name = "${var.env_name}-${var.project}-bo"
  }
}