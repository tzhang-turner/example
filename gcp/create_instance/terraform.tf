// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("/Users/mickey/Dropbox/my_docs/software/GCP/mss-cloud-arch-d56126ec2f6e.json")}"
  project     = "656086963733"
  region      = "us-central1"
}

// Create a new instance
resource "google_compute_instance" "default" {
  name         = "gce-compute-1"
  machine_type = "custom-2-2048"
  zone         = "us-central1-b"

  tags = ["letsencrypt-poc", "cloud-arch", "dev"]

  disk {
    image = "ubuntu-1404-trusty-v20160627"
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    application = "letsencrypt-poc"
    team = "cloud-arch"
    environment = "dev"
  }



  metadata_startup_script = "${file("${path.module}/provisioner.sh")}"

}
