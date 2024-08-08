resource "google_compute_subnetwork" "private-subnet" {
    name= "gke-subnet-pri"
    ip_cidr_range = "10.0.0.0/18"
    region = "us-west4"
    network = google_compute_network.vpc_network.id
    private_ip_google_access = true

    secondary_ip_range  {
        range_name = "k8s-pod-range"
        ip_cidr_range = "10.48.0.0/14"
    }

    secondary_ip_range  {
        range_name = "k8s-svc-range"
        ip_cidr_range = "10.52.0.0/20"
    }
}
