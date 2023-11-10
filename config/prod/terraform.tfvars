region  = "ap-southeast-6"
project = "imba"
env_name = "prod"

// network details
vpc_cidr = "10.0.0.0/16"
pub_a = "10.0.0.0/24"
priv_a = "10.0.2.0/24"
priv_b = "10.0.3.0/24"
priv_c = "10.0.4.0/24"
az_a = "ap-southeast-6a"

// domains
bo_domain = "gl-be-betmnl.vip"

// Back Office
#bo_fe_ami_id = "aliyun_3_x64_20G_qboot_alibase_20230727.vhd"
#bo_fe_instance_type = "ecs.t6-c4m1.large"

// db instance details
#master_instance_class = "db.t3.small"