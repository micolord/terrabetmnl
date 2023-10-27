module "bo-sg-module" {
  source  = "alibaba/security-group/alicloud"

  name        = "${var.env_name}-${var.project}-bo-sg"
  description = "Security group for bo custom ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = [var.vpc_cidr]
  ingress_rules            = ["https-443-http-8080"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "https"
      description = "User-service ports"
      cidr_blocks = var.vpc_cidr
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "http"
      description = "User-service ports"
      cidr_blocks = var.vpc_cidr
    }
  ]
  egress_cidr_blocks      = [var.vpc_cidr]
  egress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "https"
      description = "User-service ports"
      cidr_blocks = var.vpc_cidr
    }
  ]
}