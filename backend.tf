terraform {
  backend "oss" {
    bucket = "dynamic_env-imbasg-bucket"
    key   = "dynamic_env-state.tfstate"
    region = "ap-southeast-1"
  }
}