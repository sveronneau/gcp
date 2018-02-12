resource "google_compute_instance_template" "instance_template" {
  name_prefix = "instance-template-"
  description = "This template is used to create nginx server instances."
  project = "${google_project_services.project.project}"
  region      = "northamerica-northeast1"

  tags = ["foo", "bar"]

  labels = {
    environment = "dev"
  }

  instance_description = "description assigned to instances"
  machine_type         = "n1-standard-1"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image_family = "ubuntu/ubuntu-1604-lts"
    auto_delete  = true
    boot         = true
  }

  // Use an existing disk resource
#  disk {
#    source      = "foo_existing_disk"
#    auto_delete = false
#    boot        = false
#  }

  network_interface {
    network = "default"
  }

  metadata {
    foo = "bar"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  name               = "instance-group-manager"
  instance_template  = "${google_compute_instance_template.instance_template.self_link}"
  base_instance_name = "instance-group-manager"
  zone               = "northamerica-northeast1-a"
  project            = "${google_project_services.project.project}"
  target_size        = "3"
}
