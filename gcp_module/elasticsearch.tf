resource "kubernetes_manifest" "max_map_count_setter_prio" {
  count = var.external_elasticsearch_address == "" ? 1 : 0
  manifest = {
    apiVersion = "scheduling.k8s.io/v1"
    kind       = "PriorityClass"
    metadata = {
      name = "user-daemonset-priority"
    }
    value            = 999999999,
    preemptionPolicy = "PreemptLowerPriority",
    globalDefault    = "false",
    description      = "User DaemonSet priority"
  }

  computed_fields = ["globalDefault"]
  depends_on = [
    google_container_cluster.primary,
    helm_release.eck
  ]
}

resource "helm_release" "max_map_count_setter_ds" {
  count     = var.external_elasticsearch_address == "" ? 1 : 0
  name      = "${var.name_identifier}-max-map-count-setter-ds"
  chart     = "${path.module}/helm/charts/max-map-count-setter-ds"
  namespace = kubernetes_namespace.app.metadata.0.name
  wait      = true
  timeout   = 1200

  depends_on = [
    google_container_cluster.primary,
    kubernetes_manifest.max_map_count_setter_prio
  ]
}

resource "helm_release" "elasticsearch" {
  count     = var.external_elasticsearch_address == "" ? 1 : 0
  name      = "${var.name_identifier}-elasticsearch"
  chart     = "${path.module}/helm/charts/elasticsearch"
  namespace = kubernetes_namespace.app.metadata.0.name
  wait      = true
  timeout   = 1200

  values = [
    file("${path.module}/values_esearch.yaml")
  ]

  set {
    name  = "nodeSets.count"
    value = var.elasticsearch_replicas
  }
  set {
    name  = "resources.limits.cpu"
    value = var.elasticsearch_limits_cpu
  }
  set {
    name  = "resources.requests.cpu"
    value = var.elasticsearch_requests_cpu
  }
  set {
    name  = "resources.limits.mem"
    value = var.elasticsearch_limits_mem
  }
  set {
    name  = "resources.requests.mem"
    value = var.elasticsearch_requests_mem
  }
  set {
    name  = "env.es_java_opts.value"
    value = var.elasticsearch_java_opts
  }
  set {
    name  = "resources.requests.storage"
    value = var.elasticsearch_data_storage
  }

  depends_on = [
    google_container_cluster.primary,
    kubernetes_manifest.max_map_count_setter_prio,
    helm_release.max_map_count_setter_ds
  ]
}

