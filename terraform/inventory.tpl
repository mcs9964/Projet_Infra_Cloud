[master]
${master_ip}

[workers]
%{ for ip in worker_ips ~}
${ip}
%{ endfor ~}

[edge]
${edge_ip}

[all:vars]
ansible_user=${ssh_user}
ansible_ssh_private_key_file=~/.ssh/spark_gcp
