resource "google_compute_network" "vpc" {
  name                    = "main"
  routing_mode           = "REGIONAL"
  auto_create_subnetworks = false
  delete_default_routes_on_create = true //On supprime la route par défaut vers Internet pour créer une avec terraform

  depends_on = [google_project_service.compute]
}

resource "google_compute_route" "default_route" { // Route par défaut vers Internet pour NAT getaway et pour créer des subnets privés
  name       = "default_route"
  dest_range = "0.0.0.0/0"
  network    = google_compute_network.vpc.name
  next_hop_gateway = "default-internet-gateway"
}
  
