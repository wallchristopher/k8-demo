# Argo

## Self Management

During initial deployment, ArgoCD is manually deployed through the `setup` script in the root directory.
After deployment, the Helm chart is configured to update itself from the `k8s-platform` repository, enabling self-management.

## ApplicationSets

### Core Components

The core platform components are deployed using ApplicationSets, which generate deployments based on the contents of the `/bootstrap/` directory.
