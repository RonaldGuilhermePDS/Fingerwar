resource "google_dns_managed_zone" "my_zone" {
  name        = var.google_zone_name
  dns_name    = "${var.google_zone_dns_name}."

  cloud_logging_config {
    enable_logging = true
  }
}

resource "google_dns_record_set" "gke_record" {
  name = "${var.google_dns_record_name}.${google_dns_managed_zone.my_zone.dns_name}"
  type = var.google_dns_record_type
  ttl  = var.google_dns_record_ttl

  managed_zone = google_dns_managed_zone.my_zone.name

  rrdatas = [data.kubernetes_service.nginx_ingress.status[0].load_balancer[0].ingress[0].ip]
}
