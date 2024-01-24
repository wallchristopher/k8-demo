module "thanos_fargate_profile" {
  count = var.thanos_enabled && var.use_fargate_eks ? 1 : 0

  source  = "terraform-aws-modules/eks/aws//modules/fargate-profile"
  version = "~> 19.0"

  name         = "thanos"
  cluster_name = local.name

  subnet_ids = [module.vpc.private_subnets[1]]
  selectors = [
    {
      namespace = "thanos"
    }
  ]
}

module "thanos_s3_bucket" {
  count = var.thanos_enabled ? 1 : 0

  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "thanos-metrics-${var.environment}"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"
}
