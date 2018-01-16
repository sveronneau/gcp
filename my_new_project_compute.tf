data "google_compute_zones" "available" {}

variable "node_count" {
  default = "5"
}

resource "google_compute_disk" "seconddisk" {
    count   = "${var.node_count}"
    project = "${google_project_services.project.project}"
    name    = "compute-datadisk-${count.index}"
    type    = "pd-standard"
    zone    = "${data.google_compute_zones.available.names[0]}"
    size    = "5"
}

resource "google_compute_instance" "default" {
  count        = "${var.node_count}"
  project      = "${google_project_services.project.project}"
  zone         = "${data.google_compute_zones.available.names[0]}"
  name         = "compute-node-${count.index}"
  machine_type = "f1-micro"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-xenial-v20170328"
    }
  }

  attached_disk {
      disk = "compute-datadisk-${count.index}"
#"${google_compute_disk.seconddisk.name}"
  }
  
  network_interface {
    //network       = "foobar"
    subnetwork    = "subnet-na-east1"
    //network      = "${google_compute_network.custom-subnet.id}"
    //subnetwork   = "${google_compute_subnetwork.subnet1a.id}"
    subnetwork_project = "${google_project_services.project.project}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    foo = "bar"
  }

  metadata_startup_script = "sudo apt-get install traceroute"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

output "instance_id" {
  value = "${google_compute_instance.default.*.self_link}"
}
