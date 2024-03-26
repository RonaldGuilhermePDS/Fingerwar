variable "gke_cluster_name" {
  type = string
  default = "gke-cluster-dev"
}

variable "google_project_id" {
  type = string
}

variable "gke_cluster_node_pool_name" {
  type = string
  default = "gke-cluster-node-pool-dev"
}

variable "gke_region" {
  type = string
  default = "southamerica-east1-a"
}

variable "gke_pool_type" {
  type = string
  default = "e2-medium"
}

variable "gke_pool_count" {
  type = number
  default = 1
}

variable "google_service_account_email" {
  type = string
  sensitive = true
}
