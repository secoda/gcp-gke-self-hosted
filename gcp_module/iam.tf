resource "google_service_account_iam_binding" "workload_identity_binding" {
  service_account_id = google_service_account.default.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${var.project_name}.svc.id.goog[${kubernetes_namespace.app.metadata.0.name}/${var.name_identifier}]"
  ]
}

resource "google_project_iam_member" "cloudsql_client_membership" {
  role    = "roles/cloudsql.client"
  project = var.project_name
  member  = google_service_account.default.member
}

resource "google_project_iam_member" "log_writer" {
  role    = "roles/logging.logWriter"
  project = var.project_name
  member  = google_service_account.default.member
}

resource "google_project_iam_member" "metric_writer" {
  role    = "roles/monitoring.metricWriter"
  project = var.project_name
  member  = google_service_account.default.member
}

resource "google_project_iam_member" "stackdriver_writer" {
  role    = "roles/stackdriver.resourceMetadata.writer"
  project = var.project_name
  member  = google_service_account.default.member
}

