resource "google_compute_firewall" "allow-ssh" {
  name    = "spark-allow-ssh"
  network = google_compute_network.vpc.name
  allows { protocol = "tcp" ports = ["22"] }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "spark-ports" {
  name    = "spark-ports"
  network = google_compute_network.vpc.name
  allows {
    protocol = "tcp"
    ports    = ["7077","8080","8081","4040-4050"]
  }
  source_ranges = ["0.0.0.0/0"]
}
