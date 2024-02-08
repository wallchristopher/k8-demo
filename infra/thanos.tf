module "thanos_fargate_profile" {
  source  = "terraform-aws-modules/eks/aws//modules/fargate-profile"
  version = "~> 19.0"

  name         = "thanos"
  cluster_name = module.fargate_eks[0].cluster_name

  subnet_ids = [
    module.vpc.private_subnets[1]
  ]
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

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_secret" "thanos_s3_bucket" {
  metadata {
    name      = "thanos-s3-bucket"
    namespace = "monitoring"
  }

  type = "Opaque"

  data = {
    "thanos-s3-bucket.yaml" = yamlencode({
      type : "s3",
      config : {
        bucket : module.thanos_s3_bucket.s3_bucket_id,
        endpoint : "s3.us-east-1.amazonaws.com"
      }
    })
  }

  depends_on = [kubernetes_namespace.monitoring]
}
