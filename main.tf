terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"  
    }
  }
}

provider "google" {
  project     = "evident-gecko-451106-b3"
  region      = var.region
  credentials = file("evident-gecko-451106-b3-9ed9115ce3e8.json")
}

# Create a custom VPC network
resource "google_compute_network" "custom_network" {
  name                    = "custom-vpc"
  auto_create_subnetworks = false  # We will define custom subnets
}

# Create a subnet inside the custom VPC
resource "google_compute_subnetwork" "custom_subnet" {
  name          = "custom-subnet"
  network       = google_compute_network.custom_network.self_link
  ip_cidr_range = "10.10.0.0/16"
  region        = var.region
}

# Create the VM with both default and custom network
resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  # Attach default network
  network_interface {
    network = "default"
    access_config {
    }
  }

  # Attach custom network
  network_interface {
    network    = google_compute_network.custom_network.self_link
    subnetwork = google_compute_subnetwork.custom_subnet.self_link
    access_config {
    }
  }
}
