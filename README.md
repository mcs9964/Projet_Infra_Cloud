# Projet_Infra_Cloud
# Spark Cluster (GCP) — Ansible Runbook (Start / Stop)

This repository deploys a small Spark standalone cluster on GCP:
- **edge**: bastion / orchestration node (where you run Ansible)
- **master**: Spark master (private subnet)
- **slave-1 / slave-2**: Spark workers (private subnet)

> Important: the Spark nodes are in a **private subnet**. You must connect to **edge** first, then run Ansible from edge.

---

## 0) Prerequisites (one-time)

### A) SSH access from edge to private nodes
From **edge**, you must be able to SSH to the private IPs:

-- ssh <YOUR_USER>@10.0.32.5 hostname   # master
-- ssh <YOUR_USER>@10.0.32.7 hostname   # slave-1
-- ssh <YOUR_USER>@10.0.32.6 hostname   # slave-2

If SSH works, you can run Ansible.
### B) Ansible installed on edge
**On edge**:
-- ansible --version
if missing :
-- sudo apt update
-- sudo apt install -y ansible
- **1) Inventory setup (each user)**
We provide a shared template:
ansible/inventory/inventory.ini
Test inventory connectivity : 
-- ansible -i inventory/inventory.ini spark -m ping
**Expected:** pong for master and both workers.
- **3) Start Spark (master + workers)**
Start the master
-- ansible -i inventory/inventory.ini master -b -m shell -a "/opt/spark/sbin/start-master.sh"
Start the workers (slave-1 and slave-2)
-- ansible -i inventory/inventory.ini workers -b -m shell -a "/opt/spark/sbin/start-worker.sh spark://master:7077"
- **4) Verify Spark is running**
**A) Check Java processes (Spark started with sudo)**
Master:
-- ssh <YOUR_USER>@10.0.32.5 "sudo jps"
Expected to include Master.
Workers:
-- ssh <YOUR_USER>@10.0.32.7 "sudo jps"
-- ssh <YOUR_USER>@10.0.32.6 "sudo jps"
Expected to include Worker.
**B) If a worker refuses to start (already running)**
You may see:
"Worker running as process XXXX. Stop it first."
Stop workers first, then start again (see next section).
- **5) Stop Spark (workers + master)**
**Always stop workers first, then the master.**
Stop workers
-- ansible -i inventory/inventory.ini workers -b -m shell -a "/opt/spark/sbin/stop-worker.sh || true"
Stop master
-- ansible -i inventory/inventory.ini master -b -m shell -a "/opt/spark/sbin/stop-master.sh || true"
Verify:
-- ssh <YOUR_USER>@10.0.32.5 "sudo jps"
-- ssh <YOUR_USER>@10.0.32.7 "sudo jps"
-- ssh <YOUR_USER>@10.0.32.6 "sudo jps"
You should NOT see Master / Worker anymore.
- **6) Troubleshooting**
**A) Worker not running on one node**
Check the worker log on the affected node:
ssh <YOUR_USER>@10.0.32.6 "sudo tail -n 120 /opt/spark/logs/spark-root-org.apache.spark.deploy.worker.Worker-1-slave-2.out"
Common cause: hostname master not resolvable → run section (2).
**B) Ansible says "No inventory was parsed"**
You are likely using the wrong path. Use:
ansible -i ~/Projet_Infra_Cloud/ansible/inventory/inventory.ini spark -m ping
