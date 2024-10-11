# metrics-server

## Description

This installs the metrics-server chart that collects resource metrics from Kubernetes nodes, pods and the control plane API.

<!-- markdownlint-disable -->
![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-sigs.github.io/metrics-server/ | metrics-server | ^3.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| metrics-server | object | `{"commonLabels":{"repo":"k8s-platform"},"metrics":{"enabled":true},"podDisruptionBudget":{"enabled":true,"minAvailable":1},"serviceMonitor":{"enabled":true},"topologySpreadConstraints":[{"labelSelector":{"matchLabels":{"app.kubernetes.io/name":"metrics-server"}},"maxSkew":1,"topologyKey":"kubernetes.io/hostname","whenUnsatisfiable":"ScheduleAnyway"}]}` | metrics server configuration |
| metrics-server.commonLabels | object | `{"repo":"k8s-platform"}` | labels to apply to all resources |
| metrics-server.metrics | object | `{"enabled":true}` | allow access to the /metrics endpoint |
| metrics-server.podDisruptionBudget | object | `{"enabled":true,"minAvailable":1}` | setup the pod disruption budget |
| metrics-server.serviceMonitor | object | `{"enabled":true}` | setup the service monitor for prometheus |
| metrics-server.topologySpreadConstraints | list | `[{"labelSelector":{"matchLabels":{"app.kubernetes.io/name":"metrics-server"}},"maxSkew":1,"topologyKey":"kubernetes.io/hostname","whenUnsatisfiable":"ScheduleAnyway"}]` | topology spread constraints |
