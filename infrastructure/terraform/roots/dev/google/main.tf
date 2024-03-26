terraform {
  cloud {
    organization = "Fingerwar"

    workspaces {
      name = "fingerwar-google-dev"
    }
  }
}

provider "google" {
  project     = var.google_project_id
  region      = var.google_project_region
}
