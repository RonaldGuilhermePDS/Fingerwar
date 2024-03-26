provider "google" {
  project     = var.google_project_id
  region      = var.gke_region
}

resource "google_container_cluster" "primary" {
  name     = var.gke_cluster_name
  location = var.gke_region
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.gke_cluster_node_pool_name
  location   = var.gke_region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_pool_count

  node_config {
    preemptible  = true
    machine_type = var.gke_pool_type
    service_account = var.google_service_account_email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
