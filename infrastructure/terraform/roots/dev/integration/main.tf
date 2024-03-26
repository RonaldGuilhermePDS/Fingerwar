terraform {
  cloud {
    organization = "Fingerwar"
    workspaces {
      name = "fingerwar-integration-dev"
    }
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.26.0"
    }
  }
}

provider "google" {
  project     = var.google_project_id
  region      = var.gke_region
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.primary.endpoint}/"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
  )
}

module "letsencrypt" {
  source = "../../../modules/letsencrypt"
  cloud_dns_key = var.GOOGLE_CREDENTIALS
}

module "google_dns" {
  source                    = "../../../modules/dns"
  google_zone_name = var.google_zone_name
  google_zone_dns_name = var.google_zone_dns_name
  google_dns_record_name = var.google_dns_record_name
  google_dns_record_type = var.google_dns_record_type
  google_dns_record_ttl = var.google_dns_record_ttl
}

module "container_registry" {
  source = "../../../modules/container-registry"
  artifact_registry_name = var.artifact_registry_name
  artifact_registry_location = var.artifact_registry_location
  docker_registry_email = var.docker_registry_email
  docker_registry_name = var.docker_registry_name
  docker_registry_server = var.docker_registry_server
  for_each = var.docker_registry_namespaces
  docker_registry_namespace = each.value
  service_account_key = var.GOOGLE_CREDENTIALS
}
