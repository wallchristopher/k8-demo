module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_name
  cluster_version = var.eks_version
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

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

resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.eks_name} --alias ${var.eks_name}"
  }

  depends_on = [module.eks]
}

module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "~> 20.0"

  cluster_name = module.eks.cluster_name

  enable_pod_identity             = true
  create_pod_identity_association = true

  # Since the node group role will already have an access entry
  create_access_entry = false
}
