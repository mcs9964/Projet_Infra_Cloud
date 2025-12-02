locals {
  metadata_ssh = "${var.ssh_username}:${var.ssh_public_key}"
  image        = "ubuntu-os-cloud/ubuntu-2204-lts"
}

resource "google_compute_instance" "master" {
  name         = "spark-master"
  machine_type = var.master_machine
  zone         = var.zone

  boot_disk { initialize_params { image = local.image } }

  network_interface {
    subnetwork   = google_compute_subnetwork.subnet.name
    access_config {} # IP publique (pour le TP)
  }

  metadata = { ssh-keys = local.metadata_ssh }
  tags     = ["spark","master"]
}

resource "google_compute_instance" "edge" {
  name         = "spark-edge"
  machine_type = var.edge_machine
  zone         = var.zone

  boot_disk { initialize_params { image = local.image } }

  network_interface {
    subnetwork   = google_compute_subnetwork.subnet.name
    access_config {}
  }

  metadata = { ssh-keys = local.metadata_ssh }
  tags     = ["spark","edge"]
}

resource "google_compute_instance" "worker" {
  count        = var.workers_count
  name         = "spark-worker-${count.index}"
  machine_type = var.worker_machine
  zone         = var.zone

  boot_disk { initialize_params { image = local.image } }

  network_interface {
    subnetwork   = google_compute_subnetwork.subnet.name
    access_config {}
  }

  metadata = { ssh-keys = local.metadata_ssh }
  tags     = ["spark","worker"]
}
