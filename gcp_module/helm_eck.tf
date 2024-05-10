resource "helm_release" "eck" {
  count      = var.external_elasticsearch_address == "" ? 1 : 0
  name       = "elastic-operator"
  repository = "https://helm.elastic.co"
  chart      = "eck-operator"
  version    = "2.11.1"
  namespace  = kubernetes_namespace.app.metadata.0.name
  wait       = true
  timeout    = 1200

  set {
    name  = "resources.limits.cpu"
    value = "250m"
  }
  set {
    name  = "resources.limits.memory"
    value = "512Mi"
  }
  set {
    name  = "resources.limits.ephemeral-storage"
    value = "1Gi"
  }
  set {
    name  = "resources.requests.cpu"
    value = "250m"
  }
  set {
    name  = "resources.requests.memory"
    value = "512Mi"
  }
  set {
    name  = "resources.requests.ephemeral-storage"
    value = "1Gi"
  }

  depends_on = [
    google_container_cluster.primary,
    google_cloud_quotas_quota_preference.storage
  ]
}

