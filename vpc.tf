resource "alicloud_vpc" "prod-terrababa-vpc" {
  cidr_block  = "10.5.0.0/16"
  vpc_name    = "prod-terrababa-vpc"
}