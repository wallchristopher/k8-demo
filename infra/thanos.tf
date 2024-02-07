module "thanos_fargate_profile" {
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
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.1"

  bucket_prefix            = "monitoring-metrics-${var.environment}"
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  force_destroy            = true
}
