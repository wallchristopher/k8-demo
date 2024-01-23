data "utils_aws_eks_update_kubeconfig" "k8s_platform" {
  profile      = local.name
  cluster_name = local.name

  depends_on = [module.fargate_eks]
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  values = [
    "${file("${path.module}/../bootstrap/argo/values-${var.environment}.yaml")}"
  ]

  depends_on = [data.utils_aws_eks_update_kubeconfig.k8s_platform]
}
