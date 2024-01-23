# Argo

Found at: [k8s-platform/bootstrap/argo](https://github.com/wallchristopher/k8s-platform/tree/main/bootstrap/argo)

This stack is built off of the upstream [argo-helm](https://github.com/argoproj/argo-helm) set of charts.

## ArgoCD

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.

ArgoCD is a kubernetes native tool that enables the delivery of GitOps practices.  It uses a git repository as a source of truth in defining the desired state.  It is implemented as a kubernetes controller continously montoring running applications and reconciling it against the desired state in the source git repository.

## Self Management

During initial deployment, ArgoCD is manually deployed through the `setup` script in the root directory.
After deployment, the Helm chart is configured to update itself from the `k8s-platform` repository, enabling self-management.

## ApplicationSets

### Core Components

The core platform components are deployed using ApplicationSets, which generate deployments based on the contents of the `/bootstrap/` directory.
