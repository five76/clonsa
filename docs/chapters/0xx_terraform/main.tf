terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("pod2.json")

  project = "133769692933"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "left-network" {
  name                    = "left-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "left-subnet1" {
  name          = "left-subnet1"
  ip_cidr_range = "192.168.100.0/24"
  region        = "europe-west1"
  network       = google_compute_network.left-network.id
}

resource "google_compute_subnetwork" "left-subnet2" {
  name          = "left-subnet2"
  ip_cidr_range = "192.168.200.0/24"
  region        = "europe-west2"
  network       = google_compute_network.left-network.id
}

resource "google_compute_network" "right-network" {
  name                    = "right-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "right-subnet1" {
  name          = "right-subnet1"
  ip_cidr_range = "172.16.100.0/24"
  region        = "europe-west1"
  network       = google_compute_network.right-network.id
}

resource "google_compute_subnetwork" "right-subnet2" {
  name          = "right-subnet2"
  ip_cidr_range = "172.16.200.0/24"
  region        = "europe-west2"
  network       = google_compute_network.right-network.id
}

resource "google_compute_address" "left-static1" {
  name = "left-static1"
  region = "europe-west1"
}

resource "google_compute_address" "left-static2" {
  name = "left-static2"
  region = "europe-west2"
}

resource "google_compute_address" "right-static1" {
  name = "right-static1"
  region = "europe-west1"
}

resource "google_compute_firewall" "allow-ssh-left" {
  name = "allow-ssh-left"
  network = google_compute_network.left-network.id
  priority = 1000
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}


resource "google_compute_firewall" "allow-ssh-right" {
  name = "allow-ssh-right"
  network = google_compute_network.right-network.id
  priority = 1000
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}


resource "google_compute_firewall" "allow-to-webfront-left" {
  name = "allow-to-webfront-left"
  network = google_compute_network.left-network.id
  priority = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["webfront"]
  allow {
    protocol = "tcp"
    ports = ["80"]
  }
}

resource "google_compute_firewall" "allow-to-webfront-right" {
  name = "allow-to-webfront-right"
  network = google_compute_network.right-network.id
  priority = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["webfront"]
  allow {
    protocol = "tcp"
    ports = ["80"]
  }
}

resource "google_compute_firewall" "allow-internal-left" {
  name = "allow-internal-left"
  network = google_compute_network.left-network.id
  priority = 1000
  source_ranges = ["172.16.100.0/24","172.16.200.0/24","192.168.100.0/24","192.168.200.0./24"]
  allow {
    protocol = "tcp"
    ports =["22","80","443"]
  }
}

resource "google_compute_firewall" "allow-internal-right" {
  name = "allow-internal-right"
  network = google_compute_network.right-network.id
  priority = 1000
  source_ranges = ["172.16.100.0/24","172.16.200.0/24","192.168.100.0/24","192.168.200.0./24"]
  allow {
    protocol = "tcp"
    ports =["22","80","443"]
  }

}

resource "google_compute_route" "left1-out" {
  name = "left1-out"
  network = google_compute_network.left-network.id
  depends_on=[google_compute_subnetwork.left-subnet1]
  priority = 10
  dest_range = "0.0.0.0/0"
  next_hop_ip = "192.168.100.9"
}

resource "google_compute_route" "left2-out" {
  name = "left2-out"
  network = google_compute_network.left-network.id
  depends_on=[google_compute_subnetwork.left-subnet2]
  priority = 10
  dest_range = "0.0.0.0/0"
  next_hop_ip = "192.168.200.9"
}

resource "google_compute_route" "right1-out" {
  name = "right1-out"
  network = google_compute_network.right-network.id
  depends_on=[google_compute_subnetwork.right-subnet1]
  priority = 10
  dest_range = "0.0.0.0/0"
  next_hop_ip = "172.16.100.9"
}


resource "google_compute_route" "right2-out" {
  name = "right2-out"
  network = google_compute_network.right-network.id
  depends_on=[google_compute_subnetwork.right-subnet2]
  priority = 10
  dest_range = "0.0.0.0/0"
  next_hop_ip = "172.16.200.9"
}


