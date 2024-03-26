variable "gke_cluster_name" {
  type = string
  default = "gke-cluster-dev"
}

variable "gke_region" {
  type = string
  default = "southamerica-east1-a"
}

variable "google_project_id" {
  type = string
}

variable "cert_manager_acme_email" {
  type    = string
  sensitive = true
}

variable "google_zone_name" {
  type = string
  default = "fingerwar-zone"
}

variable "google_zone_dns_name" {
  type = string
  default = "fingerwar.com.br"
}

variable "google_dns_record_name" {
  type = string
  default = "*"
}

variable "google_dns_record_type" {
  type = string
  default = "A"
}

variable "google_dns_record_ttl" {
  type = number
  default = 1
}

variable "artifact_registry_name" {
  type = string
  default = "container-registry-gke-dev"
}

variable "artifact_registry_location" {
  type = string
  default = "southamerica-east1"
}

variable "GOOGLE_CREDENTIALS" {
  type = string
  sensitive = true
}

variable "docker_registry_server" {
  type = string
  default = "southamerica-east1-docker.pkg.dev"
}

variable "docker_registry_name" {
  type = string
  default = "docker-registry-config"
}

variable "docker_registry_namespaces" {
  type = set(string)
  default = ["core"]
}

variable "docker_registry_email" {
  type = string
}
