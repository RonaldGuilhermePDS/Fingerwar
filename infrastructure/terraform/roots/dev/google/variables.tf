variable "google_project_id" {
  type = string

  default = "active-pier-415919"
}

variable "google_project_region" {
  type = string

  default = "southamerica-east1"
}

variable "google_services_name" {
  type = set(string)

  default = [ "compute.googleapis.com", "container.googleapis.com" ]
}
