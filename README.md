# k8s-platform

Kuberentes platform running on EKS Fargate compute nodes.

> To play around with Kubernetes and various open source tools

## Getting Started

Pre-requisites:

- Target AWS account with necessary permissions
- AWS CLI configured to use the target account `aws confuigure`
- Terraform
- Kubectl
- Helm

The setup script should be run from the root of the repository. This will deploy the necessary infrastructure and tools to the target AWS account.
The script will also configure your kubeclt to use the newly created cluster.

```bash
./setup
```

## Documentation

Further documentation is located within the docs directory.
