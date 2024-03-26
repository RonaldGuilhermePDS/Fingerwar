data "google_client_config" "provider" {}

data "google_container_cluster" "primary" {
  name     = var.gke_cluster_name
  location = var.gke_region
}
