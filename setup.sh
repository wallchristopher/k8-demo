#!/bin/bash
set -e

read -p "Enter your cluster name: " clustername

terraform -chdir=./platform/terraform init
terraform -chdir=./platform/terraform apply

aws eks --region us-east-1 update-kubeconfig --name "$clustername"
