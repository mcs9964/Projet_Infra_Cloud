resource "google_compute_instance" "edge" {
  name         = "edge"
  machine_type = "n1-standard-1"
  zone         = local.zone

  tags = ["ssh-iap", "ansible"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"

    }
  }

  lifecycle {
    ignore_changes = [
      metadata["ssh-keys"]
    ]
  }

  network_interface {
    subnetwork = google_compute_subnetwork.public.id
  }

  depends_on = [
    google_project_service.compute,
    google_compute_subnetwork.public,
    google_compute_router_nat.nat,
    google_compute_route.defaultroute,
  ]
}

resource "google_compute_instance" "master" {
  name         = "master"
  machine_type = "n1-standard-1"
  zone         = local.zone

  tags = ["ssh-iap", "spark"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"

    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private.id
  }

  depends_on = [
    google_project_service.compute,
    google_compute_subnetwork.private,
    google_compute_router_nat.nat,
  ]
}

resource "google_compute_instance" "slave_1" {
  name         = "slave-1"
  machine_type = "n1-standard-1"
  zone         = local.zone

  tags = ["ssh-iap", "spark"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"

    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private.id
  }

  depends_on = [
    google_project_service.compute,
    google_compute_subnetwork.private,
    google_compute_router_nat.nat,
  ]
}

resource "google_compute_instance" "slave_2" {
  name         = "slave-2"
  machine_type = "n1-standard-1"
  zone         = local.zone

  tags = ["ssh-iap", "spark"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"

    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private.id
  }

  depends_on = [
    google_project_service.compute,
    google_compute_subnetwork.private,
    google_compute_router_nat.nat,
  ]
}
