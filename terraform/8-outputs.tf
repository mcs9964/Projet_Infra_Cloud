output "edge_internal_ip" {
  value       = google_compute_instance.edge.network_interface[0].network_ip
  description = "Internal IP of the edge VM"
}

output "master_internal_ip" {
  value       = google_compute_instance.master.network_interface[0].network_ip
  description = "Internal IP of the master VM"
}

output "slave_1_internal_ip" {
  value       = google_compute_instance.slave_1.network_interface[0].network_ip
  description = "Internal IP of slave-1 VM"
}

output "slave_2_internal_ip" {
  value       = google_compute_instance.slave_2.network_interface[0].network_ip
  description = "Internal IP of slave-2 VM"
}
