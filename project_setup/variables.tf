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

variable "region" {
  description = "Secoda deploy region"
  type        = string
}

variable "secoda_folder" {
  type        = string
  description = "folder name"
}

variable "secoda_project" {
  type        = string
  description = "project name"
}
