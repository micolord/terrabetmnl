terraform {
  backend "oss" {
    bucket = "dynamic_env-imba-bucket"
    key   = "dynamic_env-state.tfstate"
    region = "ap-southeast-6"
  }

  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
      version = "1.212.0"
    }
  }

}