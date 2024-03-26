variable "artifact_registry_name" {
  type = string
}

variable "artifact_registry_location" {
  type = string
}

variable "service_account_key" {
  type = string
  sensitive = true
}

variable "docker_registry_server" {
  type = string
}

variable "docker_registry_name" {
  type = string
}

variable "docker_registry_namespace" {
  type = string
}

variable "docker_registry_email" {
  type = string
}
