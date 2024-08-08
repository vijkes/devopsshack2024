provider "google" {
    credentials = file("/home/hpuser/.config/gcloud/application_default_credentials.json")
    project = "devsecops-431009"
    region = "us-west4"

}

terraform {
  backend "gcs" {
    bucket = "gke-cicd-july"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "~> 4.0"
    }
  }
}
