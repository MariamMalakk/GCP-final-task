resource "google_compute_instance" "instance-1" {
  name         = "instance-1"
  machine_type = "f1-micro"
  zone         = "asia-east1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"

    }
  }


  network_interface {
    subnetwork = google_compute_subnetwork.management-subnet.id
  }
  service_account {

    email  = google_service_account.service-account.email
    scopes = ["cloud-platform"]
  }


  metadata_startup_script = <<-EOF
        sudo apt-get update
        sudo apt-get install -y ca-certificates curl
        sudo apt-get install -y apt-transport-https
        sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
        echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
        sudo apt-get update
        sudo apt-get install -y kubectl
        EOF
}
