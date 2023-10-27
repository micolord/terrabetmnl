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
  password = random_password.password.result

  system_disk_category = "cloud_essd"
  system_disk_size     = 100

  tags = {
    Name      = "${var.env_name}-${var.project}-bo"

  }
}

resource "alicloud_kms_secret" "bo-pw" {
  secret_name                   = "${var.env_name}-${var.project}-bo-pw"
  description                   = "from terraform"
  secret_data                   = random_password.password.result
  version_id                    = "1.0"
  force_delete_without_recovery = true
}

resource "random_password" "password" {
  length           = 10
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}