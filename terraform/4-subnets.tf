resource "google_compute_subnetwork" "public" { //Un subnet public pour le edge node car c'est avec lui qu'on aura une connexion
// ssh depuis l'extérieur  et lui il va faire un submit au master spark dans le subnet privé
    name                    = "public"
    ip_cidr_range           = "10.0.0.0/19"
    region                  = local.region
    network                 = google_compute_network.vpc.id
    private_ip_google_access = true
    stack_type               = "IPV4_ONLY"
}


resource "google_compute_subnetwork" "private" { //Subnet privé pour master et nodes spark
    name                    = "private"
    ip_cidr_range           = "10.0.32.0/19"
    region                  = local.region
    network                 = google_compute_network.vpc.id
    private_ip_google_access = true // pour que les VM dans ce subnet privé puissent accéder aux API google
    stack_type               = "IPV4_ONLY"
}