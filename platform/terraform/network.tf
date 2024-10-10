data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  enable_nat_gateway      = true
  one_nat_gateway_per_az  = var.vpc_one_nat_gateway_per_az
  single_nat_gateway      = var.vpc_single_nat_gateway
  enable_dns_hostnames    = true
  map_public_ip_on_launch = true

  azs = local.azs
  // Database Subnets /22)
  database_subnets = [for index, az in local.azs : cidrsubnet(var.vpc_cidr, 6, index + 30)]
  database_subnet_tags = {
    tier = "database"
  }
  // Private Subnets /18
  private_subnets = [for index, az in local.azs : cidrsubnet(var.vpc_cidr, 2, index)]
  private_subnet_tags = {
    tier                              = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
  // Public Subnets /22
  public_subnets = [for index, az in local.azs : cidrsubnet(var.vpc_cidr, 6, index + 10)]
  public_subnet_tags = {
    tier                     = "public"
    "kubernetes.io/role/elb" = 1
  }
  // Intra Subnets /22
  intra_subnets = [for index, az in local.azs : cidrsubnet(var.vpc_cidr, 6, index + 20)]
  intra_subnet_tags = {
    tier                     = "intra"
    "kubernetes.io/role/elb" = 1
  }
}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 5.7"

  vpc_id = module.vpc.vpc_id

  create_security_group      = true
  security_group_name_prefix = "k8s-platform-vpc-endpoints-"
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }

  endpoints = {
    ecr_api = {
      private_dns_enabled = true
      service             = "ecr.api"
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "ecr-api-vpc-endpoint" }
    },
    ecr_dkr = {
      private_dns_enabled = true
      service             = "ecr.dkr"
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "ecr-dkr-vpc-endpoint" }
    }
    dynamodb = {
      route_table_ids = module.vpc.private_route_table_ids
      service         = "dynamodb"
      service_type    = "Gateway"
      tags            = { Name = "dynamodb-vpc-endpoint" }
    },
    s3 = {
      route_table_ids = module.vpc.private_route_table_ids
      service         = "s3"
      service_type    = "Gateway"
      tags            = { Name = "s3-vpc-endpoint" }
    }
  }
}
