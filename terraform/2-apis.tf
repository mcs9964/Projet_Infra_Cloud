resource "google_project_service" "compute" { // ca c'est l'API pour créer des VM
  project = local.project_id
  service = "compute.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "container" { // in case on utilise Kubernetes
  project = local.project_id
  service = "container.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "logging" { // pour activer les logs
  project = local.project_id
  service = "logging.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "secretmanager" { // pour utiliser le Secret Manager ( utile pour les pods dans kubernetes )
  project = local.project_id
  service = "secretmanager.googleapis.com"

  disable_on_destroy = false
}