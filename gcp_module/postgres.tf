resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "random_password" "database_password" {
  length  = 16
  special = false
}

resource "google_sql_database_instance" "postgres" {
  name                = "postgres-${var.name_identifier}-${random_id.db_name_suffix.hex}"
  database_version    = var.postgres_db_version
  deletion_protection = false

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    disk_autoresize       = true
    disk_autoresize_limit = 2048

    database_flags {
      name  = "max_connections"
      value = 1000
    }

    availability_type = "REGIONAL"

    tier = var.postgres_db_tier
    backup_configuration {
      enabled            = true
      binary_log_enabled = false
      start_time         = "00:05"

      backup_retention_settings {
        retention_unit   = "COUNT"
        retained_backups = 14
      }
    }
    ip_configuration {
      ipv4_enabled                                  = false
      require_ssl                                   = true
      private_network                               = google_compute_network.vpc.self_link
      enable_private_path_for_google_cloud_services = true
    }
  }
}

resource "google_sql_user" "users" {
  name            = "keycloak"
  instance        = google_sql_database_instance.postgres.name
  password        = random_password.database_password.result
  deletion_policy = "ABANDON"

}
