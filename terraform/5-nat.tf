resource "google_compute_address" "nat" { //Pour de la sécurité les VMs comme elles n'auront pas
//d'IP externe, on va créer une NAT getaway qui va permettre aux VMs dans le subnet privé d'accéder à Internet
  name    = "nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"

  depends_on = [google_project_service.compute]
}


resource "google_compute_router" "router" {
  name    = "router"
  network = google_compute_network.vpc.name
  region  = local.region

  depends_on = [google_project_service.compute]
}

resource "google_compute_router_nat" "nat" {
  name                       = "nat"
  router                     = google_compute_router.router.name
  region                     = local.region

  nat_ip_allocate_option     = "MANUAL_ONLY"
  nat_ips                    = [google_compute_address.nat.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS" // Pour que toutes les VMs dans tous les subnets puissent accéder à Internet

  depends_on = [google_compute_router.router]

  subnetwork {
    name                    = google_compute_subnetwork.private.id // On configure la NAT getaway pour le subnet privé, le subnet "public" avec l'edge
    //node n'en a pas besoin car il a une IP externe
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
