provider "google" {
  credentials = "${var.credentials}"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "ansible" {
  count        = "1"
  project      = "${var.project}"
  zone         = "${var.zone}"
  name         = "vault-node-${count.index}"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

# This is where we configure the instance with ansible-playbook
  provisioner "local-exec" {
    command = "sleep 90; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u your_sshkey_user --private-key your_private_key -i '${google_compute_instance.ansible.network_interface.0.access_config.0.assigned_nat_ip}', master.yml"  }

  network_interface {
    network       = "default"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
