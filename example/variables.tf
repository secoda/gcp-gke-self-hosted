# Customer Setup Vars
variable "billing_account" {
  description = "The ID of the GCP billing account to associate projects with"
  type        = string
  default     = ""
}

variable "org_id" {
  description = "The GCP organization id for the associated resources (12 digit number)"
  type        = string
  default     = ""
}

variable "org_name" {
  description = "The GCP organization domain name for the associated resources (usually a domain name)"
  type        = string
  default     = ""
}

variable "gcp_contact_email" {
  type        = string
  description = "contact email for quota increase"
  default     = ""
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "docker_password" {
  type = string
}

variable "project_name" {
  type        = string
  description = "project id"
  default     = "secoda"
}

variable "folder_name" {
  type        = string
  description = "folder name"
  default     = "secoda"
}

variable "name_identifier" {
  type        = string
  description = "unique name identifier"
  default     = "secoda"

  validation {
    condition     = can(regex("^[0-9a-z-]+$", var.name_identifier))
    error_message = "must be lower case letters, numbers or dash"
  }
}

variable "authorized_domains" {
  type        = string
  description = "comma separated list of domains- double backslash escape the commas for helm parsing, like \\,"
  default     = "secoda.co"
}

variable "domain" {
  type        = string
  description = "domain"
  default     = "secoda.co"
}

variable "fqdn" {
  type        = string
  description = "fqdn of proxy"
  default     = "example.secoda.co"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace"
  default     = "secoda"
}

# VPC Network Setup
variable "subnet_cidr" {
  type        = string
  description = "subnet cidr"
  default     = "10.10.0.0/16"
}

variable "private_svcs_net" {
  type        = string
  description = "cidr for postgres and redis servers"
  default     = "10.9.0.0"
}

variable "pod_cidr" {
  type        = string
  description = "subnet name"
  default     = "10.11.0.0/16"
}

variable "service_cidr" {
  type        = string
  description = "subnet name"
  default     = "10.12.0.0/16"
}

variable "gcp_ssd_quota" {
  type        = number
  description = "increase ssd quota for project"
  default     = 5000
}

# Postgres DB, Redis and Elasticsearch settings
variable "external_elasticsearch_address" {
  # format: https://elastic.mydomain.com:9200
  # Setting this will disable Kubernetes elasticsearch provisioning
  type    = string
  default = ""
}

variable "external_elasticsearch_user" {
  type    = string
  default = ""
}

variable "external_elasticsearch_password" {
  type    = string
  default = ""
}

variable "external_redis_address" {
  # format: redis://redis.mydomain.com:6379
  # format with auth: redis://username:password@redis.mydomain.com:6379
  # Setting this will disable Kubernetes redis provisioning
  type    = string
  default = ""
}

variable "external_redis_user" {
  # not currently used, include auth in connection URL
  type    = string
  default = ""
}

variable "external_redis_password" {
  # not currently used, include auth in connection URL
  type    = string
  default = ""
}

# Postgres DB Settings
variable "postgres_db_tier" {
  type        = string
  description = "postgres db tier"
  default     = "db-custom-2-3840"
}

variable "postgres_db_version" {
  type        = string
  description = "postgres db version"
  default     = "POSTGRES_14"
}

# Redis Replicas
variable "redis_replicas" {
  type        = string
  description = "number of replicas in redis cluster minimum 0 = master node only"
  default     = "0"
}

# Redis container resources
variable "redis_limits_cpu" {
  type        = string
  description = "redis cpu limit"
  default     = "512m"
}

variable "redis_requests_cpu" {
  type        = string
  description = "redis cpu request"
  default     = "512m"
}

variable "redis_limits_mem" {
  type        = string
  description = "redis mem limit"
  default     = "1024Mi"
}

variable "redis_requests_mem" {
  type        = string
  description = "redis mem request"
  default     = "1024Mi"
}

# Elasticsearch replicas
variable "elasticsearch_replicas" {
  type        = string
  description = "number of nodes in elasticsearch cluster minimum 1"
  default     = "1"
}

# Elasticsearch container resources
variable "elasticsearch_limits_cpu" {
  type        = string
  description = "elasticsearch cpu limit"
  default     = "1000m"
}

variable "elasticsearch_requests_cpu" {
  type        = string
  description = "elasticsearch cpu request"
  default     = "1000m"
}

variable "elasticsearch_limits_mem" {
  type        = string
  description = "elasticsearch mem limit"
  default     = "4080Mi"
}

variable "elasticsearch_requests_mem" {
  type        = string
  description = "elasticsearch mem request"
  default     = "4080Mi"
}

variable "elasticsearch_java_opts" {
  type        = string
  description = "elasticsearch java opts"
  default     = "-Xms2g -Xmx2g"
}

variable "elasticsearch_data_storage" {
  type        = string
  description = "elasticsearch persistent data storage"
  default     = "2Gi"
}

# API container limits
variable "api_limits_cpu" {
  type        = string
  description = "api cpu limit"
  default     = "2048m"
}

variable "api_requests_cpu" {
  type        = string
  description = "api cpu request"
  default     = "2048m"
}

variable "api_limits_mem" {
  type        = string
  description = "api mem limit"
  default     = "20480Mi"
}

variable "api_requests_mem" {
  type        = string
  description = "api mem request"
  default     = "20480Mi"
}

# Frontend container limits
variable "frontend_limits_cpu" {
  type        = string
  description = "frontend cpu limit"
  default     = "512m"
}

variable "frontend_requests_cpu" {
  type        = string
  description = "frontend cpu request"
  default     = "512m"
}

variable "frontend_limits_mem" {
  type        = string
  description = "frontend mem limit"
  default     = "2048Mi"
}

variable "frontend_requests_mem" {
  type        = string
  description = "frontend mem request"
  default     = "2048Mi"
}

# DockerHub Config - Do Not Modify
variable "docker_username" {
  type    = string
  default = "secodaonpremise"
}

variable "docker_server" {
  description = "docker server"
  default     = "https://index.docker.io/v1/"
}

variable "docker_artifact_registry_address" {
  type    = string
  default = "secoda"
}

variable "docker_artifact_api_name" {
  type    = string
  default = "on-premise-api"
}

variable "docker_artifact_frontend_name" {
  type    = string
  default = "on-premise-frontend"
}

variable "docker_email" {
  type    = string
  default = "carter@secoda.co"
}

