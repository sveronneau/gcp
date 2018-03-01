provider "google" {
  credentials = "${var.credentials}"
  project = "${var.project}"
  region  = "${var.region}"
}
#
# Template creation
resource "google_compute_instance_template" "instance_template" {
  name_prefix = "${var.prefix}"
  description = "${var.desc}"
  project = "${var.project}"
  region  = "${var.region}"
  tags = ["${var.tags}"]
  instance_description = "${var.desc_inst}"
  machine_type = "${var.machine_type}"
  can_ip_forward = false // No public IP will be allocated

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image (Lets use one created by Packer)
  disk {
    source_image = "${var.source_image}"
    auto_delete  = true
    boot = true
  }

  network_interface {
    network = "${var.network}"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
#
# MIG creation
resource "google_compute_instance_group_manager" "instance_group_manager" {
  instance_template = "${google_compute_instance_template.instance_template.self_link}" // points to self since we are creating it in the same script
  name = "${var.mig_name}"
  base_instance_name = "${var.base_instance_name}"
  project = "${var.project}"
  zone = "${var.zone}"
  target_size = "${var.target_size}"

  named_port {
    name = "http"
    port = 80
  }

  named_port {
    name = "https"
    port = 443
  }
}
#
# Firewall rules for specific Tags
resource "google_compute_firewall" "default" {
  name    = "${var.fwr_name}"
  network = "${var.network}"
  project = "${var.project}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  target_tags = ["${var.tags}"]
}
