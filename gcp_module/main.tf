provider "google" {
  project               = var.project_name
  billing_project       = var.project_name
  region                = var.region
  user_project_override = true
}

provider "helm" {
  kubernetes {
    insecure = true
    host     = "https://${google_container_cluster.primary.endpoint}"
    token    = data.google_client_config.default.access_token
  }
  /*
  experiments {
    manifest = true
  }
  */
}

provider "kubernetes" {
  insecure = true
  host     = "https://${google_container_cluster.primary.endpoint}"
  token    = data.google_client_config.default.access_token
}

resource "google_cloud_quotas_quota_preference" "storage" {
  parent        = "projects/${var.project_name}"
  name          = "compute-googleapis-com-ssd-total-storage-per-project-${var.region}"
  dimensions    = { region = var.region }
  service       = "compute.googleapis.com"
  quota_id      = "SSD-TOTAL-GB-per-project-region"
  contact_email = var.gcp_contact_email
  quota_config {
    preferred_value = var.gcp_ssd_quota
  }
}

# google_client_config and kubernetes provider must be explicitly specified like the following.
# Retrieve an access token as the Terraform runner
data "google_client_config" "default" {}

data "google_project" "project" {}

