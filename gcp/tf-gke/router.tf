resource "google_compute_router" "router" {
  name = "gke-router"
  region = "us-west4"
  network = google_compute_network.vpc_network.id
}
