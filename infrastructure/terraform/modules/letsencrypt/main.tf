terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.26.0"
    }
  }
}

resource "kubernetes_secret" "cloud_dns_secret" {
  type = "Opaque"

  metadata {
    name = "cloud-dns-key-secret"
    namespace = "cert-manager"
  }

  data = {
    key-json = var.cloud_dns_key
  }
}

resource "kubernetes_manifest" "cluster_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"

    metadata = {
      name = "letsencrypt-production"
    }

    spec = {
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory"
        privateKeySecretRef = {
          name = "letsencrypt-production"
        }
        solvers = [{
          dns01 = {
            cloudDNS = {
              project = "annular-haven-410818"
              serviceAccountSecretRef = {
                name      = "cloud-dns-key-secret"
                namespace = "cert-manager"
                key       = "key-json"
              }
            }
          }
        }]
      }
    }
  }
}
