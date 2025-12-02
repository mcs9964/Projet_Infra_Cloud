variable "project_id"        { type = string }
variable "region"            { type = string  default = "europe-west1" }
variable "zone"              { type = string  default = "europe-west1-b" }
variable "credentials_file"  { type = string  default = "../tf-admin.json" }
variable "ssh_username"      { type = string  default = "n7" }
variable "ssh_public_key"    { type = string }
variable "spark_version"     { type = string  default = "3.5.1" }
variable "master_machine"    { type = string  default = "e2-standard-4" }
variable "worker_machine"    { type = string  default = "e2-standard-4" }
variable "edge_machine"      { type = string  default = "e2-standard-2" }
variable "workers_count"     { type = number  default = 3 }
