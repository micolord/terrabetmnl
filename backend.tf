terraform {
  backend "oss" {
    bucket = "prod-terrababa-oss"
    key   = "version-1.tfstate"
    region = "ap-southeast-6"
    tablestore_endpoint = "https://prod-terrababa.ap-southeast-6.ots.aliyuncs.com"
    tablestore_table = "prod_statelock"
  }
}