# k8s-platform

Kubernetes platform that leverages different tools to help engineers build, deploy, run, maintain their code in a Kubernetes ecosystem.

## Why?

To play around with Kubernetes and various open source tools inside to see how they work and how they can be used to help engineers.

## What's Inside?

- [apps](apps) - Contains the applications that will be deployed to the Kubernetes cluster to test the platform.
- [terraform](platform/terraform) - Contains the Terraform code to deploy the Kubernetes cluster to AWS.
- [helm](platform/charts) - Contains the Helm charts to deploy the applications to the Kubernetes cluster.

## Getting Started

Pre-requisites:

- Target AWS account with necessary permissions
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) - configured with target AWS account
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/)

### Production Deployment

Run the following commands within the root of this repo to deploy the platform to the target AWS account.

The [setup](setup.sh) script contains the above commands with some error handling.

### Local Development

To deploy to a local cluster without any cloud provider requirements. Refer to the [local development](docs/local-development.md) documentation.

## Documentation

Further documentation is located within the [docs](docs) directory.
