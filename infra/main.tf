locals {
  name            = "k8s-platform"
  cluster_version = "1.28"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
}

#######################
##### FARGATE EKS #####
#######################

module "fargate_eks" {
  count = var.use_fargate_eks ? 1 : 0

  source = "./modules/fargate"

  cluster_name    = local.name
  cluster_version = local.cluster_version
  azs             = local.azs
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  intra_subnets   = module.vpc.intra_subnets

  thanos_s3_bucket_name = module.thanos_s3_bucket.s3_bucket_arn
}

##########################
##### NODE GROUP EKS #####
##########################

module "node_eks" {
  count = var.use_fargate_eks ? 0 : 1

  source = "./modules/ec2_nodes"

  cluster_name    = local.name
  cluster_version = local.cluster_version
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  intra_subnets   = module.vpc.intra_subnets
}

################################
##### SUPPORTING RESOURCES #####
################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]
  intra_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 52)]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${local.name} --alias ${local.name}"
  }

  depends_on = [module.fargate_eks]
}
