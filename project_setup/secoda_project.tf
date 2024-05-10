resource "google_folder" "secoda_folder" {
  display_name = var.secoda_folder
  parent       = "organizations/${var.org_id}"
}

resource "google_project" "secoda_project" {
  name            = var.secoda_project
  project_id      = var.secoda_project
  folder_id       = google_folder.secoda_folder.name
  billing_account = var.billing_account
}

resource "google_project_service" "secoda_project_compute" {
  project = google_project.secoda_project.id
  service = "compute.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_project_service" "secoda_project_k8s" {
  project = google_project.secoda_project.id
  service = "container.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_project_service" "secoda_project_sql" {
  project = google_project.secoda_project.id
  service = "sqladmin.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_project_service" "secoda_project_svcnet" {
  project = google_project.secoda_project.id
  service = "servicenetworking.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_project_service" "secoda_project_certs" {
  project = google_project.secoda_project.id
  service = "certificatemanager.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_project_service" "secoda_project_logging" {
  project = google_project.secoda_project.id
  service = "logging.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_project_service" "secoda_project_quotas" {
  project = google_project.secoda_project.id
  service = "cloudquotas.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_project_service" "secoda_project_resourcemanager" {
  project = google_project.secoda_project.id
  service = "cloudresourcemanager.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

output "project_id" {
  value = google_project.secoda_project.project_id
}

output "project_full_id" {
  value = google_project.secoda_project.id
}

output "project_number" {
  value = google_project.secoda_project.number
}
