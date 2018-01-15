# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

data "google_compute_zones" "available" {}

variable "node_count" {
  default = "5"
}

resource "google_compute_instance" "default" {
  count        = "5"
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
