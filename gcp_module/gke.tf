resource "google_service_account" "default" {
  account_id   = var.name_identifier
  display_name = var.name_identifier
}

resource "google_container_cluster" "primary" {
  name             = "${var.name_identifier}-gke-primary"
  location         = var.region
  enable_autopilot = true

  cluster_autoscaling {
    auto_provisioning_defaults {
      service_account = google_service_account.default.email
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
      ]
    }
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.pod_cidr
    services_ipv4_cidr_block = var.service_cidr
  }

  service_external_ips_config {
    enabled = true
  }

  private_cluster_config {
    enable_private_nodes = true
  }

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  deletion_protection = false
  depends_on = [
    module.cloud_router
  ]
}
