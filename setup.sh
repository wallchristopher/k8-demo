#!/bin/bash
set -e

read -p "Enter your cluster name: " CLUSTER_NAME

TF_WORKDIR=$(platform/terraform)

terraform -chdir=$TF_WORKDIR init
terraform -chdir=$TF_WORKDIR apply -tfvars=$TF_WORKDIR/tfvars/prod.tfvars

aws eks --region us-east-1 update-kubeconfig --name "$CLUSTER_NAME"
