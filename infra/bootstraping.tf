resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name k8s-platform --kubeconfig ~/.kube/eks"
  }

  depends_on = [module.fargate_eks]
}

resource "helm_release" "argo_bootstrap" {
  name              = "argocd"
  chart             = "argo-cd"
  namespace         = "argocd"
  repository        = "https://argoproj.github.io/argo-helm"
  create_namespace  = true
  dependency_update = true

  depends_on = [null_resource.kubectl]
}

resource "helm_release" "argocd" {
  name      = "argocd"
  chart     = "${path.module}/../bootstrap/argo/"
  namespace = "argocd"

  values = [
    file("${path.module}/../bootstrap/argo/values-${var.environment}.yaml")
  ]

  depends_on = [
    null_resource.kubectl,
    helm_release.argo_bootstrap
  ]
}
