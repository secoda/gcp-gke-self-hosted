variable "billing_account" {
  description = "The ID of the billing account to associate projects with"
  type        = string
}

variable "org_id" {
  description = "The organization id for the associated resources"
  type        = string
}

variable "org_name" {
  description = "The organization domain name for the associated resources"
  type        = string
}

variable "gcp_contact_email" {
  description = "contact email for GCP quota increase"
  type        = string
}

variable "region" {
  type = string
}

variable "docker_email" {
  type = string
}

variable "docker_username" {
  type = string
}

variable "docker_password" {
  type = string
}

variable "docker_server" {
  description = "docker server"
}

variable "docker_artifact_registry_address" {
  type = string
}

variable "docker_artifact_api_name" {
  type = string
}

variable "docker_artifact_frontend_name" {
  type = string
}

variable "external_elasticsearch_address" {
  # format: https://elastic.mydomain.com:9200
  type = string
}

variable "external_elasticsearch_user" {
  type = string
}

variable "external_elasticsearch_password" {
  type = string
}

variable "external_redis_address" {
  # format: redis://redis.mydomain.com:6379
  type = string
}

variable "external_redis_user" {
  type = string
}

variable "external_redis_password" {
  type = string
}

variable "project_name" {
  type        = string
  description = "project id"
}

variable "name_identifier" {
  type        = string
  description = "unique name identifier"

  validation {
    condition     = can(regex("^[0-9a-z-]+$", var.name_identifier))
    error_message = "must be lower case letters, numbers or dash"
  }
}

variable "authorized_domains" {
  type        = string
  description = "comma separated list of domains- double backslash escape the commas for helm parsing"
}

variable "domain" {
  type        = string
  description = "domain"
}

variable "fqdn" {
  type        = string
  description = "fqdn of proxy"
}

variable "namespace" {
  type        = string
  description = "namespace"
}

variable "subnet_cidr" {
  type        = string
  description = "subnet cidr"
}

variable "private_svcs_net" {
  type        = string
  description = "cidr for postgres and redis servers"
}

variable "pod_cidr" {
  type        = string
  description = "subnet name"
}

variable "service_cidr" {
  type        = string
  description = "subnet name"
}

variable "gcp_ssd_quota" {
  type        = number
  description = "increase ssd quota for project"
}

# Postgres DB Settings
variable "postgres_db_tier" {
  type        = string
  description = "postgres db tier"
}

variable "postgres_db_version" {
  type        = string
  description = "postgres db version"
}

# Redis Replicas
variable "redis_replicas" {
  type        = string
  description = "number of replicas in redis cluster minimum 0 = master node only"
}

variable "redis_limits_cpu" {
  type        = string
  description = "redis cpu limit"
}

variable "redis_requests_cpu" {
  type        = string
  description = "redis cpu request"
}

variable "redis_limits_mem" {
  type        = string
  description = "redis mem limit"
}

variable "redis_requests_mem" {
  type        = string
  description = "redis mem request"
}

# Elasticsearch replicas
variable "elasticsearch_replicas" {
  type        = string
  description = "number of nodes in elasticsearch cluster minimum 1"
}

# Elasticsearch container resources
variable "elasticsearch_limits_cpu" {
  type        = string
  description = "elasticsearch cpu limit"
}

variable "elasticsearch_requests_cpu" {
  type        = string
  description = "elasticsearch cpu request"
}

variable "elasticsearch_limits_mem" {
  type        = string
  description = "elasticsearch mem limit"
}

variable "elasticsearch_requests_mem" {
  type        = string
  description = "elasticsearch mem request"
}

variable "elasticsearch_java_opts" {
  type        = string
  description = "elasticsearch java opts"
}

variable "elasticsearch_data_storage" {
  type        = string
  description = "elasticsearch persistent data storage"
}

# API container limits
variable "api_limits_cpu" {
  type        = string
  description = "api cpu limit"
}

variable "api_requests_cpu" {
  type        = string
  description = "api cpu request"
}

variable "api_limits_mem" {
  type        = string
  description = "api mem limit"
}

variable "api_requests_mem" {
  type        = string
  description = "api mem request"
}

# Frontend container limits
variable "frontend_limits_cpu" {
  type        = string
  description = "frontend cpu limit"
}

variable "frontend_requests_cpu" {
  type        = string
  description = "frontend cpu request"
}

variable "frontend_limits_mem" {
  type        = string
  description = "frontend mem limit"
}

variable "frontend_requests_mem" {
  type        = string
  description = "frontend mem request"
}

