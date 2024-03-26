terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.26.0"
    }
  }
}

resource "google_artifact_registry_repository" "repository" {
  location      = var.artifact_registry_location
  repository_id = var.artifact_registry_name
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}

resource "kubernetes_secret" "docker_registry" {
  type = "kubernetes.io/dockerconfigjson"

  metadata {
    name      = var.docker_registry_name
    namespace = var.docker_registry_namespace
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.docker_registry_server}" = {
          username = "_json_key"
          password = var.service_account_key
          email = var.docker_registry_email
          auth = base64encode("_json_key:${var.service_account_key}")
        }
      }
    })
  }
}
