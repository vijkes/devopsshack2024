provider "google" {

    credentials = "/home/hpuser/.config/gcloud/application_default_credentials.json"
    project = "devops-cicd-430308"
    region = "us-east4"

}

resource "google_storage_bucket" "bucket" {
    name = "imagesagacom"
    location = "US"
    force_destroy = true

}

resource "google_storage_bucket_object" "pci" {
    name="tf-logo"
    source = "/home/hpuser/tf/bucket/terraform-icon-1803x2048-hodrzd3t.png"
    bucket = google_storage_bucket.bucket.name

}
