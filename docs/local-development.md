# Local Development

## Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Rancher Desktop](https://rancherdesktop.io/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

Ensure your local cluster is running and kubernetes context is set to the local cluster.

## Deploying the Platform

Run the following commands within the root of the repo directory to deploy the platform to your local cluster.

```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd \
  --namespace argocd \
  --create-namespace \
  --dependency-update
helm upgrade argocd ./bootstrap/argo/ \
  --namespace argocd \
  -f ./bootstrap/argo/values.yaml
```
