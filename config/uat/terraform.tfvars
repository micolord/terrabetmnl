region  = "ap-southeast-6"
project = "imba"
env_name = "uat"

// network details
vpc_cidr = "10.1.0.0/16"
pub_a = "10.1.0.0/24"
priv_a = "10.1.2.0/24"
priv_b = "10.1.3.0/24"
priv_c = "10.1.4.0/24"
az_a = "ap-southeast-6a"

// domains
gl_fe_domain = "betmnl-uat.vip"
gl_be_domain = "gl-be.betmnl-uat.vip"
bo_fe_domain = "bo-fe.betmnl-uat.vip"
bo_be_domain = "bo-be.betmnl-uat.vip"
jobproc_domain = "jobproc.betmnl-uat.vip"
socket_domain  = "socket.betmnl-uat.vip"
cert_id = "52346-ap-southeast-1"

// Back Office
#bo_fe_ami_id = "aliyun_3_x64_20G_qboot_alibase_20230727.vhd"
#bo_fe_instance_type = "ecs.t6-c4m1.large"

// db instance details
#master_instance_class = "db.t3.small"