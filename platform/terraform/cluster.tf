module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_name
  cluster_version = var.eks_version
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    core = {
      ami_type       = "AL2_x86_64"
      instance_types = ["t3.micro"]

      min_size     = 3
      max_size     = 3
      desired_size = 3
    }
  }

  cloudwatch_log_group_retention_in_days = 1

  enable_cluster_creator_admin_permissions = true
}

module "external_secrets_pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "~> 1.0"

  name            = "external-secrets"
  use_name_prefix = false

  attach_external_secrets_policy        = true
  external_secrets_create_permission    = true
  external_secrets_secrets_manager_arns = ["arn:aws:secretsmanager:*:*:*:*"]

  association_defaults = {
    namespace       = "external-secrets"
    service_account = "external-secrets"
  }

  associations = {
    platform = {
      cluster_name = module.eks.cluster_name
    }
  }
}

module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "~> 20.0"

  cluster_name = module.eks.cluster_name

  enable_pod_identity             = true
  create_pod_identity_association = true

  node_iam_role_use_name_prefix = false
  node_iam_role_name            = "karpenter-node"

  enable_v1_permissions = true

  queue_name = "Karpenter"
}
