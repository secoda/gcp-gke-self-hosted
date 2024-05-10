
resource "google_compute_ssl_certificate" "default" {
  name = var.name_identifier

  certificate = tls_self_signed_cert.lb.cert_pem
  private_key = tls_private_key.lb.private_key_pem

  lifecycle {
    create_before_destroy = true
  }
}

resource "tls_private_key" "jwt" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "random_uuid" "secret_key" {}

resource "random_uuid" "admin_password" {}

resource "google_compute_global_address" "static" {
  address_type = "EXTERNAL"
  name         = var.name_identifier
}

resource "helm_release" "secoda" {
  name      = var.name_identifier
  chart     = "${path.module}/helm/charts/secoda"
  namespace = kubernetes_namespace.app.metadata.0.name
  wait      = true
  timeout   = 1800

  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name  = "cloudSqlAuthProxy.databaseName"
    value = "${var.project_name}:${var.region}:${google_sql_database_instance.postgres.name}"
  }
  set {
    name  = "serviceAccount.annotations.iam\\.gke\\.io/gcp-service-account"
    value = google_service_account.default.email
  }
  set {
    name  = "serviceAccount.name"
    value = var.name_identifier
  }
  set {
    name  = "ingress.hosts[0].host"
    value = var.fqdn
  }
  set {
    name  = "ingress.annotations.kubernetes\\.io/ingress\\.global-static-ip-name"
    value = google_compute_global_address.static.name
  }
  set {
    name  = "datastores.secoda.authorized_domains"
    value = var.authorized_domains
  }
  set {
    name  = "datastores.secoda.existing_secret"
    value = ""
  }
  set {
    name  = "datastores.secoda.db_host"
    value = "localhost" # Since we are using the proxy.
  }
  set {
    name  = "datastores.secoda.db_password"
    value = random_password.database_password.result
  }
  set {
    name  = "datastores.secoda.secret_key"
    value = random_uuid.secret_key.result
  }
  set {
    name  = "datastores.secoda.admin_password"
    value = random_uuid.admin_password.result
  }
  set {
    name  = "datastores.secoda.private_key"
    value = base64encode(tls_private_key.jwt.private_key_pem)
  }
  set {
    name  = "datastores.secoda.public_key"
    value = base64encode(tls_private_key.jwt.public_key_pem)
  }
  set {
    name  = "datastores.secoda.api_host"
    value = "apisvc"
  }
  set {
    name  = "datastores.secoda.es_host"
    value = var.external_elasticsearch_address == "" ? "http://elasticsearch-es-http:9200" : var.external_elasticsearch_address
  }
  set {
    name  = "datastores.secoda.es_username"
    value = var.external_elasticsearch_address == "" ? "elastic" : var.external_elasticsearch_user
  }
  set {
    name  = "datastores.secoda.es_password"
    value = var.external_elasticsearch_address == "" ? data.kubernetes_secret.elastic_password.0.data["elastic"] : var.external_elasticsearch_password
  }
  set {
    name  = "datastores.secoda.redis_host"
    value = var.external_redis_address == "" ? "redis://redis-master:6379" : var.external_redis_address
  }
  set {
    name  = "datastores.secoda.redis_username"
    value = var.external_redis_address == "" ? "redis-user" : var.external_elasticsearch_user
  }
  set {
    name  = "datastores.secoda.redis_password"
    value = var.external_redis_address == "" ? "" : var.external_elasticsearch_password
  }

  set {
    name  = "services.api.image.registry"
    value = var.docker_artifact_registry_address
  }
  set {
    name  = "services.api.image.name"
    value = var.docker_artifact_api_name
  }

  set {
    name  = "services.api.resources.requests.cpu"
    value = var.api_requests_cpu
  }
  set {
    name  = "services.api.resources.limits.cpu"
    value = var.api_limits_cpu
  }
  set {
    name  = "services.api.resources.requests.memory"
    value = var.api_requests_mem
  }
  set {
    name  = "services.api.resources.limits.memory"
    value = var.api_limits_mem
  }

  set {
    name  = "services.frontend.image.registry"
    value = var.docker_artifact_registry_address
  }
  set {
    name  = "services.frontend.image.name"
    value = var.docker_artifact_frontend_name
  }

  set {
    name  = "services.frontend.resources.requests.cpu"
    value = var.frontend_requests_cpu
  }
  set {
    name  = "services.frontend.resources.limits.cpu"
    value = var.frontend_limits_cpu
  }
  set {
    name  = "services.frontend.resources.requests.memory"
    value = var.frontend_requests_mem
  }
  set {
    name  = "services.frontend.resources.limits.memory"
    value = var.frontend_limits_mem
  }

  depends_on = [
    google_container_cluster.primary,
    google_sql_database_instance.postgres,
    helm_release.redis,
    google_cloud_quotas_quota_preference.storage
  ]
}
