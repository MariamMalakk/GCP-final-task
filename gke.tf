resource "google_container_cluster" "gke1" {
  name     = "priv-gke-cluster"
  location = "asia-east1-b"
  network                  = google_compute_network.myvpc.id
  subnetwork = google_compute_subnetwork.restricted-subnet.id

  remove_default_node_pool = true
  initial_node_count       = 1

  master_authorized_networks_config {
    cidr_blocks {
      display_name = "management_subnet"
      cidr_block = "10.0.0.0/24"
      
    }

   
}
 ip_allocation_policy {
    
  }
 private_cluster_config {
    
    enable_private_nodes    = true   
    enable_private_endpoint = true
    master_ipv4_cidr_block = "172.16.0.0/28"
  }

  
  }




resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "node-pool-1"
  location = "asia-east1-b"

  cluster    = google_container_cluster.gke1.name
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = "g1-small"

    service_account = google_service_account.service-account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}