resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    master_ip = google_compute_instance.master.network_interface[0].access_config[0].nat_ip
    edge_ip   = google_compute_instance.edge.network_interface[0].access_config[0].nat_ip
    worker_ips= [for w in google_compute_instance.worker : w.network_interface[0].access_config[0].nat_ip]
    ssh_user  = var.ssh_username
  })
  filename = "${path.module}/../ansible/inventories/generated/hosts.ini"
}
