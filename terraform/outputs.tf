output "master_public_ip"  { value = google_compute_instance.master.network_interface[0].access_config[0].nat_ip }
output "edge_public_ip"    { value = google_compute_instance.edge.network_interface[0].access_config[0].nat_ip }
output "worker_public_ips" { value = [for w in google_compute_instance.worker : w.network_interface[0].access_config[0].nat_ip] }
