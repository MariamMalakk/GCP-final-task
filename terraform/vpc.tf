resource "google_compute_network" "myvpc" {
  name                    = "myvpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "management-subnet" {
  name                     = "management-subnet"
  ip_cidr_range            = "10.0.0.0/24"
  private_ip_google_access = true
  network                  = google_compute_network.myvpc.id
}

resource "google_compute_subnetwork" "restricted-subnet" {
  name                     = "restricted-subnet"
  ip_cidr_range            = "10.0.1.0/24"
  private_ip_google_access = true
  network                  = google_compute_network.myvpc.id
}

resource "google_compute_firewall" "firewall-1" {
  name                    = "allow-http-ssh"
  network                 = google_compute_network.myvpc.name
  source_ranges           = ["0.0.0.0/0"]
  source_service_accounts = [google_service_account.service-account.email]

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "22"]
  }

}
