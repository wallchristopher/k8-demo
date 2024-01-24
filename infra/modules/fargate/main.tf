module "fargate_eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_version
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
      configuration_values = jsonencode({
        computeType = "Fargate"
      })
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.intra_subnets

  # Fargate profiles use the cluster primary security group so these are not utilized
  create_cluster_security_group = false
  create_node_security_group    = false

  fargate_profile_defaults = {
    iam_role_additional_policies = {
      additional = aws_iam_policy.additional.arn
    }
  }

  fargate_profiles = merge(
    {
      k8s-platform = {
        name = "k8s-platform"
        selectors = [
          {
            namespace = "default"
          }
        ]
        subnet_ids = var.private_subnets
        timeouts = {
          create = "20m"
          delete = "20m"
        }
      }

      argocd = {
        name = "argocd"
        selectors = [
          {
            namespace = "argocd"
          }
        ]
        subnet_ids = var.private_subnets
        timeouts = {
          create = "20m"
          delete = "20m"
        }
      }

      monitoring = {
        name = "monitoring"
        selectors = [
          {
            namespace = "monitoring"
          }
        ]
        subnet_ids = var.private_subnets
        timeouts = {
          create = "20m"
          delete = "20m"
        }
      }

      core = {
        name = "core"
        selectors = [
          {
            namespace = "core"
          }
        ]
        subnet_ids = var.private_subnets
        timeouts = {
          create = "20m"
          delete = "20m"
        }
      }
    },
    { for i in range(3) :
      "kube-system-${element(split("-", var.azs[i]), 2)}" => {
        selectors = [
          { namespace = "kube-system" }
        ]
        # We want to create a profile per AZ for high availability
        subnet_ids = [element(var.private_subnets, i)]
      }
    }
  )
}

resource "aws_iam_policy" "additional" {
  name = "${var.cluster_name}-additional"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
