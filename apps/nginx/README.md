# nginx

## Description

<!-- markdownlint-disable -->
![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.27.2](https://img.shields.io/badge/AppVersion-1.27.2-informational?style=flat-square)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` | This is to override the chart fullname. |
| image.pullPolicy | string | `"IfNotPresent"` | This sets the pull policy for images |
| image.repository | string | `"nginx"` | The repository to pull the image from |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | This is for the secretes for pulling an image from a private repository more information can be found here: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| nameOverride | string | `""` | This is to override the chart name. |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` | Configuration for setting Kubernetes Annotations to a Pod. |
| podDisruptionBudget | object | `{"enabled":true,"maxUnavailable":1,"minAvailable":1}` | Configuration for pod disruption budgets |
| podDisruptionBudget.enabled | bool | `true` | whether to create a pod disruption budget |
| podDisruptionBudget.maxUnavailable | int | `1` | The maximum number of pods that can be unavailable during an update |
| podDisruptionBudget.minAvailable | int | `1` | The minimum number of pods that must be available at any given time |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe.httpGet.path | string | `"/"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| replicaCount | int | `1` | The number of replicas to run |
| resources | object | `{}` | resource request and limits for the pods |
| securityContext | object | `{}` |  |
| service | object | `{"port":80,"type":"ClusterIP"}` | Service configuration |
| serviceAccount | object | `{"annotations":{},"automount":true,"create":true,"name":""}` | Service Account configuration |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. # If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |
