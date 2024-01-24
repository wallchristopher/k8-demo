data "utils_aws_eks_update_kubeconfig" "k8s_platform" {
  alias        = local.name
  cluster_name = local.name
  profile      = "default"

  depends_on = [module.fargate_eks]
}

resource "helm_release" "argocd" {
  name              = "argocd"
  chart             = "${path.module}/../bootstrap/argo/"
  namespace         = "argocd"
  create_namespace  = true
  dependency_update = true

  values = [
    "${file("${path.module}/../bootstrap/argo/values-${var.environment}.yaml")}"
  ]

  depends_on = [data.utils_aws_eks_update_kubeconfig.k8s_platform]
}
