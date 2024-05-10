resource "helm_release" "redis" {
  count      = var.external_redis_address == "" ? 1 : 0
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  namespace  = kubernetes_namespace.app.metadata.0.name
  wait       = true
  timeout    = 1200

  values = [
    file("${path.module}/values_redis.yaml")
  ]
  set {
    name  = "auth.enabled"
    value = "false"
  }
  set {
    name  = "master.resources.limits.cpu"
    value = var.redis_limits_cpu
  }
  set {
    name  = "master.resources.limits.memory"
    value = var.redis_limits_mem
  }
  set {
    name  = "resources.requests.cpu"
    value = var.redis_requests_cpu
  }
  set {
    name  = "resources.requests.memory"
    value = var.redis_requests_mem
  }
  set {
    name  = "replica.replicaCount"
    value = var.redis_replicas
  }

  depends_on = [
    google_container_cluster.primary,
    google_cloud_quotas_quota_preference.storage
  ]
}

