resource "google_compute_firewall" "allow_iap_ssh" {
    name    = "allow-iap-ssh"
    network = google_compute_network.vpc.name
    
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    
    source_ranges = ["35.235.240.0/20"]
    target_tags   = ["ssh-iap"] //les VMs qui ont ce tag seulement pourront être accessible via IAP SSH
}


resource "google_compute_firewall" "allow_ssh_internal_ansible" {
  name    = "allow-ssh-internal-ansible"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["ansible"] //ici on utilise source tag et pas source rages car à chaque lancer de terraform
  //l'edge node peut avoir une IP interne différente, donc on tag l'edge node avec ansible pour le reconnaitre
  //peut importe son IP interne
  target_tags = ["spark"]
}
