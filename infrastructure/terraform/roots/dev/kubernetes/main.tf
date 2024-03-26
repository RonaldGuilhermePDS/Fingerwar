terraform { 
  cloud {
    organization = "Fingerwar"
    workspaces {
      name = "fingerwar-kubernetes-dev"
    }
  }
}

provider "google" {
  project     = var.google_project_id
  region      = var.gke_region
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.primary.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.primary.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
    )
  }
}

module "k8s_namespaces" {
  source = "../../../modules/k8s-namespaces"
  for_each = var.kubernetes_namespaces
  kubernates_namespace = each.value
}

module "nginx_ingress" {
  depends_on = [module.k8s_namespaces]
  source     = "../../../modules/nginx"
}

module "cert_manager" {
  depends_on = [module.nginx_ingress]
  source     = "../../../modules/cert-manager"
}
