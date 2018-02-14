provider "google" {
  credentials = "${file("gcp_service_account.json")}"
  project = "your_gcp_project"
  region  = "northamerica-northeast1"
}

data "google_compute_zones" "available" {}

variable "node_count" {
  default = "3"
}

resource "google_compute_disk" "seconddisk" {
    count   = "${var.node_count}"
    project = "your_gcp_project"
    name    = "compute-datadisk-${count.index}"
    type    = "pd-ssd"
    zone    = "${data.google_compute_zones.available.names[0]}"
    size    = "80"
}

resource "google_compute_instance" "default" {
  count        = "${var.node_count}"
  project      = "your_gcp_project"
  zone         = "${data.google_compute_zones.available.names[0]}"
  name         = "glusterfs-node-${count.index}"
  machine_type = "n1-standard-1"

  tags = ["glusterfs", "xmldation"]

  boot_disk {
    initialize_params {
      image = "glusterfs"
    }
  }

  attached_disk {
    source      = "${element(google_compute_disk.seconddisk.*.self_link, count.index)}"
    device_name = "seconddisk"
  }

  network_interface {
    network       = "default"
    //subnetwork    = "default"
    //network      = "${google_compute_network.custom-subnet.id}"
    //subnetwork   = "${google_compute_subnetwork.subnet1a.id}"
    //subnetwork_project = "${google_project_services.project.project}"

    //access_config {
      // Ephemeral IP
    //}
  }

  metadata {
    foo = "glusterfs"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

output "instance_id" {
  value = "${google_compute_instance.default.*.self_link}"
}

output "public_ip" {
   value = ["${google_compute_instance.default.*.network_interface.0.access_config.0.assigned_nat_ip}"]
}
