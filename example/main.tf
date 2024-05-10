module "project_setup" {
  source            = "../project_setup"
  region            = var.region
  billing_account   = var.billing_account
  org_id            = var.org_id
  org_name          = var.org_name
  secoda_project    = var.project_name
  secoda_folder     = var.folder_name
}


module "secoda_deploy" {
  source = "../gcp_module"

  billing_account                  = var.billing_account
  org_id                           = var.org_id
  org_name                         = var.org_name
  gcp_contact_email = var.gcp_contact_email
  region                           = var.region
  docker_email                     = var.docker_email
  docker_username                  = var.docker_username
  docker_password                  = var.docker_password
  docker_server                    = var.docker_server
  docker_artifact_registry_address = var.docker_artifact_registry_address
  docker_artifact_api_name         = var.docker_artifact_api_name
  docker_artifact_frontend_name    = var.docker_artifact_frontend_name
  external_elasticsearch_address   = var.external_elasticsearch_address
  external_elasticsearch_user      = var.external_elasticsearch_user
  external_elasticsearch_password  = var.external_elasticsearch_password
  external_redis_address           = var.external_redis_address
  external_redis_user              = var.external_redis_user
  external_redis_password          = var.external_redis_password
  project_name                     = var.project_name
  name_identifier                  = var.name_identifier
  authorized_domains               = var.authorized_domains
  domain                           = var.domain
  fqdn                             = var.fqdn
  namespace                        = var.namespace
  subnet_cidr                      = var.subnet_cidr
  private_svcs_net                 = var.private_svcs_net
  pod_cidr                         = var.pod_cidr
  service_cidr                     = var.service_cidr
  gcp_ssd_quota                    = var.gcp_ssd_quota
  postgres_db_tier                 = var.postgres_db_tier
  postgres_db_version              = var.postgres_db_version
  redis_replicas                   = var.redis_replicas
  redis_limits_cpu                 = var.redis_limits_cpu
  redis_requests_cpu               = var.redis_requests_cpu
  redis_limits_mem                 = var.redis_limits_mem
  redis_requests_mem               = var.redis_requests_mem
  elasticsearch_replicas           = var.elasticsearch_replicas
  elasticsearch_limits_cpu         = var.elasticsearch_limits_cpu
  elasticsearch_requests_cpu       = var.elasticsearch_requests_cpu
  elasticsearch_limits_mem         = var.elasticsearch_limits_mem
  elasticsearch_requests_mem       = var.elasticsearch_requests_mem
  elasticsearch_java_opts          = var.elasticsearch_java_opts
  elasticsearch_data_storage       = var.elasticsearch_data_storage
  api_limits_cpu                   = var.api_limits_cpu
  api_requests_cpu                 = var.api_requests_cpu
  api_limits_mem                   = var.api_limits_mem
  api_requests_mem                 = var.api_requests_mem
  frontend_limits_cpu              = var.frontend_limits_cpu
  frontend_requests_cpu            = var.frontend_requests_cpu
  frontend_limits_mem              = var.frontend_limits_mem
  frontend_requests_mem            = var.frontend_requests_mem
}

output "ingress_external_ip" {
  value = module.secoda_deploy.ingress_external_ip
}
