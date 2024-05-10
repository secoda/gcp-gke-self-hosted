terraform {
  required_version = ">= 1.6"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.19"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.26"
    }
  }

  /*
  backend "remote" {
    organization = "myorg"
    workspaces {
      name = "secoda"
    }
  }
  */
}

