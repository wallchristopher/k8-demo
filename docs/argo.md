# Argo

## Self Management

During initial deployment, ArgoCD is manually deployed through the `setup` script in the root directory. After deployment the Helm chart is pointed to update itself from the `k8s-platform` repository beginning self management.

## App of Apps Deployment

### Core Components

The core platform components are deployed in the App of Apps partern under the `/bootstrap/core` directory
