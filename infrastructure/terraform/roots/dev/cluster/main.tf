terraform { 
  cloud {
    organization = "Fingerwar"
    workspaces {
      name = "fingerwar-cluster-dev"
    }
  }
}

provider "google" {
  project     = var.google_project_id
  region      = var.gke_region
}

module "gke_cluster" {
  source = "../../../modules/gke"
  gke_cluster_name = var.gke_cluster_name
  gke_cluster_node_pool_name = var.gke_cluster_node_pool_name
  gke_pool_count = var.gke_pool_count
  gke_region = var.gke_region
  google_project_id = var.google_project_id
  gke_pool_type = var.gke_pool_type
  google_service_account_email = var.google_service_account_email
}