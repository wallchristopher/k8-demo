# k8s-platform

Kubernetes platform that leverages diffent tools to help engineers build, deploy, run, maintain their code in a Kubernetes ecosystem.

## Why?

To play around with Kubernetes and various open source tools inside to see how they work and how they can be used to help engineers.

## Getting Started

Pre-requisites:

- Target AWS account with necessary permissions
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) - configured with target AWS account
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/)

### Production Deployment

Run the following commands within the root of this repo to deploy the platform to the target AWS account.

```bash
terraform -chdir=./infra init
terraform -chdir=./infra apply

aws eks update-kubeconfig --name k8s-platform

helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd \
  --namespace argocd \
  --create-namespace \
  --dependency-update
helm upgrade argocd ./bootstrap/argo/ \
  --namespace argocd \
  -f ./bootstrap/argo/values.yaml
```

The [setup](setup) script contains the above commands with some error handling.

### Local Development

To deploy to a local cluster without any cloud provider requiremnts. Refer to the [local development](docs/local-development.md) documentation.

## Documentation

Further documentation is located within the [docs](docs) directory.
