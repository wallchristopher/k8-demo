# Monitoring

Found at: [k8s-platform/bootstrap/monitoring](https://github.com/wallchristopher/k8s-platform/tree/main/bootstrap/monitoring)

This stack is built off of the upstream [kube-prometheus](https://github.com/prometheus-community/helm-charts/charts/kube-prometheus-stack)

## Alertmanager

Alertmanager is the frontend used for sending and managing alerts for a prometheus-stack installation. Out of the box this package installs a single replica of both prometheus and alertmanager which are pre-configured to sync. Alerts are evaluated and generated within Prometheus and then posted to the REST API for Alertmanager to manage based on it's configuration.

## Prometheus

Prometheus is an open-source time-series database and alerting platform. To push metrics to Prometheus, you can either integrate your application with client library, or configure an existing exporters for a third-party application such as PostgreSQL. Prometheus collects and stores its metrics as time series data ( i.e. metrics information is stored with the timestamp at which it was recorded, alongside optional key-value pairs called labels) and it comes with basic visualization capability.

## Thanos

Thanos is a set of components that can be composed into a highly available, multi Prometheus metric system with potentially unlimited storage capacity. It is not apart of the core set of applications however monitoring automatically installs the Thanos sidecar.

For local development the promethues data is stored in a local directory. This is for testing/demo purposes only.

## Grafana

Grafana is an open source interactive data-visualization platform, developed by Grafana Labs, which allows users to see their data via charts and graphs that are unified into one dashboard (or multiple dashboards!) for easier interpretation and understandin
