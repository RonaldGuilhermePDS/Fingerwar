resource "kubernetes_namespace" "custom_namespace" {
  metadata {
    name = var.kubernates_namespace

    annotations = {
      name = var.kubernates_namespace
    }

    labels = {
      mylabel = var.kubernates_namespace
    }
  }
}
