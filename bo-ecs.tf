data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_18.*64"
}

module "bo-ecs-module" {
  source  = "alibaba/ecs-instance/alicloud"

  number_of_instances = 2

  name                        = "${var.env_name}-${var.project}-bo"
  use_num_suffix              = true
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = "ecs.g7.large"
  vswitch_id                  = module.vpc.vswitch_ids[1]
  security_group_ids          = [alicloud_security_group.bo-sg.id]
  associate_public_ip_address = false
  password = "dynamic_random_password"

  system_disk_category = "cloud_essd"
  system_disk_size     = 100

  tags = {
    Name      = "${var.env_name}-${var.project}-bo"

  }
}
