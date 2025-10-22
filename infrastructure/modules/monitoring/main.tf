resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = "51.2.0"

  values = [
    yamlencode({
      prometheus = {
        prometheusSpec = {
          serviceMonitorSelectorNilUsesHelmValues = false
          podMonitorSelectorNilUsesHelmValues = false
          retention = "7d"
          resources = {
            requests = {
              memory = "512Mi"
              cpu = "250m"
            }
            limits = {
              memory = "1Gi"
              cpu = "500m"
            }
          }
        }
      }
      grafana = {
        adminPassword = "admin123"
        service = {
          type = "LoadBalancer"
        }
        resources = {
          requests = {
            memory = "128Mi"
            cpu = "100m"
          }
          limits = {
            memory = "256Mi"
            cpu = "200m"
          }
        }
      }
      alertmanager = {
        enabled = false
      }
    })
  ]

  timeout = 600

  depends_on = [kubernetes_namespace.monitoring]
}