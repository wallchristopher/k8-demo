# external-secrets

## Description

This installs the external-secrets chart and all of its infrastructure
through the use of helm and terraform.

This chart includes custom resources for ExternalSecrets. Meaning the base chart and crds need to be installed
first before installing this chart.

```bash
helm repo add external-secrets https://charts.external-secrets.io
helm install external-secrets external-secrets/external-secrets
```

<!-- markdownlint-disable -->
![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.10](https://img.shields.io/badge/AppVersion-0.10-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.external-secrets.io | external-secrets | ^0.10 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterSecretStore | object | `{"parameterStore":{"additionalLabels":{},"name":"parameterstore","provider":{"aws":{"region":"us-east-1","service":"ParameterStore"}}},"secretsManager":{"additionalLabels":{},"name":"secretsmanager","provider":{"aws":{"region":"us-east-1","service":"SecretsManager"}}}}` | configuration for the cluster secret store # this can be accessed by all namespaces within the cluster |
| clusterSecretStore.parameterStore.additionalLabels | object | `{}` | additional labels for ClusterSecretStore |
| clusterSecretStore.parameterStore.provider | object | `{"aws":{"region":"us-east-1","service":"ParameterStore"}}` | provider configuration |
| clusterSecretStore.parameterStore.provider.aws | object | `{"region":"us-east-1","service":"ParameterStore"}` | the secret provider |
| clusterSecretStore.parameterStore.provider.aws.region | string | `"us-east-1"` | AWS region |
| clusterSecretStore.parameterStore.provider.aws.service | string | `"ParameterStore"` | the backend AWS service |
| clusterSecretStore.secretsManager.additionalLabels | object | `{}` | additional labels for ClusterSecretStore |
| clusterSecretStore.secretsManager.provider | object | `{"aws":{"region":"us-east-1","service":"SecretsManager"}}` | provider configuration |
| clusterSecretStore.secretsManager.provider.aws | object | `{"region":"us-east-1","service":"SecretsManager"}` | the secret provider |
| clusterSecretStore.secretsManager.provider.aws.region | string | `"us-east-1"` | AWS region |
| clusterSecretStore.secretsManager.provider.aws.service | string | `"SecretsManager"` | the backend AWS service |
| commonLabels | object | `{"repo":"k8s-platform"}` | additional labels for all resources |
| external-secrets.commonLabels.replicaCount | int | `1` | the number of pods to run |
| external-secrets.commonLabels.repo | string | `"k8s-platform"` |  |
| external-secrets.commonLabels.serviceMonitor | object | `{"enabled":true}` | service monitor configuration |
| external-secrets.commonLabels.serviceMonitor.enabled | bool | `true` | enable service monitor |
| external-secrets.global | object | `{"topologySpreadConstraints":[{"labelSelector":{"matchLabels":{"app.kubernetes.io/name":"external-secrets"}},"maxSkew":1,"topologyKey":"kubernetes.io/hostname","whenUnsatisfiable":"ScheduleAnyway"}]}` | global configuration |
| external-secrets.global.topologySpreadConstraints | list | `[{"labelSelector":{"matchLabels":{"app.kubernetes.io/name":"external-secrets"}},"maxSkew":1,"topologyKey":"kubernetes.io/hostname","whenUnsatisfiable":"ScheduleAnyway"}]` | topology spread constraints |
| external-secrets.podDisruptionBudget | object | `{"enabled":true,"minAvailable":1}` | pod disruption budget configuration |
| external-secrets.podDisruptionBudget.enabled | bool | `true` | - enable pod disruption budget |
| external-secrets.podDisruptionBudget.minAvailable | int | `1` | - minimum available pods |
