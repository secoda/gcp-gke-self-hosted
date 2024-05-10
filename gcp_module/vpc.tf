################################################################################
# Networking
################################################################################

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.name_identifier}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name_identifier}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.subnet_cidr
}

resource "google_compute_global_address" "private_services" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  ip_version    = "IPV4"
  prefix_length = 16
  network       = google_compute_network.vpc.self_link
  address       = var.private_svcs_net
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_services.name]
}

resource "google_compute_firewall" "allow_postgres" {
  name      = "allow-postgres"
  network   = google_compute_network.vpc.name
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }
  source_service_accounts = [
    "${data.google_project.project.number}-compute@developer.gserviceaccount.com",
    google_service_account.default.email
  ]
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 6.0"
  project = var.project_name
  name    = "gke-cloud-router-${var.name_identifier}"
  network = google_compute_network.vpc.name
  region  = var.region

  nats = [{
    name                               = "gke-nat-gateway-${var.name_identifier}"
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
    subnetworks = [
      {
        name                    = google_compute_subnetwork.subnet.id
        source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE"]
      }
    ]
  }]
}
