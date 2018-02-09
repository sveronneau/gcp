// Configure the Google Cloud provider

provider "google" {
  credentials = "${file("gcp_service_account.json")}"
  project = "your_gcp_project"
  region  = "northamerica-northeast1"
}

resource "google_compute_instance" "ansible" {
  count        = "1"
  project      = "your_gcp_project"
  zone         = "northamerica-northeast1-a"
  name         = "consul-node-${count.index}"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-xenial-v20170328"
    }
  }

#  # This is where we configure the instance with ansible-playbook
  provisioner "local-exec" {
    command = "sleep 90; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u your_key_username --private-key ./my_private_key -i '${google_compute_instance.ansible.network_interface.0.access_config.0.assigned_nat_ip}', master.yml"
  }
  
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
