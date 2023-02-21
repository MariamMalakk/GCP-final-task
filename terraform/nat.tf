resource "google_compute_router_nat" "nat1" {
  name                               = "nat1"
  router                             = google_compute_router.router1.name
  region                             = google_compute_router.router1.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.management-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}


resource "google_compute_router" "router1" {
  name    = "router1"
  region  = google_compute_subnetwork.management-subnet.region
  network = google_compute_network.myvpc.id
}
