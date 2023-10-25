region  = "ap-southeast-6"
project = "imba"
env_name = "prod"

// network details
vpc_cidr = "10.5.0.0/16"
public_subnet_cidr_1 = "10.5.0.0/24"
public_subnet_cidr_2 = "10.5.1.0/24"
private_subnet_cidr_1 = "10.5.2.0/24"
private_subnet_cidr_2 = "10.5.3.0/24"
#private_subnet_cidr_3 = "10.5.4.0/24"
#private_subnet_cidr_4 = "10.5.5.0/24"
#private_subnet_cidr_5 = "10.5.6.0/24"
#private_subnet_cidr_6 = "10.5.7.0/24"
#private_subnet_cidr_7 = "10.5.8.0/24"
#private_subnet_cidr_8 = "10.5.9.0/24"
availability_zone_1 = "ap-southeast-6a"
#availability_zone_2 = "ap-northeast-1c"


// Back Office
#bo_fe_ami_id = "aliyun_3_x64_20G_qboot_alibase_20230727.vhd"
#bo_fe_instance_type = "ecs.t6-c4m1.large"

// db instance details
#master_instance_class = "db.t3.small"