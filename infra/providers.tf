provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      name = "k8s-platform"
      repo = "wallchristopher/k8s-platform"
    }
  }
}

locals {
  host                   = var.use_fargate_eks ? module.fargate_eks[0].cluster_endpoint : module.node_eks[0].cluster_endpoint
  cluster_ca_certificate = var.use_fargate_eks ? module.fargate_eks[0].cluster_certificate_authority_data : module.node_eks[0].cluster_certificate_authority_data
}

provider "kubernetes" {
  host                   = local.host
  cluster_ca_certificate = base64decode(local.cluster_ca_certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", local.name]
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
