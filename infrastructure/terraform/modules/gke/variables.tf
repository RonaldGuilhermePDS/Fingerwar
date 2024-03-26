variable "gke_cluster_name" {
  type = string
}

variable "google_project_id" {
  type = string
}

variable "gke_cluster_node_pool_name" {
  type = string
}

variable "gke_region" {
  type = string
}

variable "gke_pool_type" {
  type = string
}

variable "gke_pool_count" {
  type = number
  default = 1
}

variable "google_service_account_email" {
  type = string
  sensitive = true
}