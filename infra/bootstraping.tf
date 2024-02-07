resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${local.name}"
  }

  depends_on = [module.fargate_eks]
}

resource "helm_release" "argocd" {
  name              = "argocd"
  chart             = "${path.module}/../bootstrap/argo/"
  namespace         = "argocd"
  create_namespace  = true
  dependency_update = true
  replace           = true

  values = [
    file("${path.module}/../bootstrap/argo/values-${var.environment}.yaml")
  ]

  depends_on = [
    null_resource.kubectl
  ]

  lifecycle {
    ignore_changes = [
      values
    ]
  }
}
