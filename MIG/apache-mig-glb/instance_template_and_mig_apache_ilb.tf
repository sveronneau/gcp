#
# Credentials
provider "google" {
  credentials = "${var.credentials}"
  project = "${var.project}"
  region  = "${var.region}"
}
#
# Backend Services
resource "google_compute_backend_service" "rbs" {
  name             = "${var.be_name}"
  port_name        = "${var.be_port_name}"
  protocol         = "${var.be_protocol}"
  timeout_sec      = "${var.be_timeout}"
  session_affinity = "${var.be_session_affinity}"

  backend {
    group = "${google_compute_region_instance_group_manager.rmig.instance_group}"
  }

  health_checks = ["${google_compute_http_health_check.default.self_link}"]
}

resource "google_compute_http_health_check" "default" {
  name               = "${var.hc_name}"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}
#
# Regional MIG
resource "google_compute_region_instance_group_manager" "rmig" {
  name               = "${var.rmig_name}"
  instance_template  = "${google_compute_instance_template.cit.self_link}"
  base_instance_name = "${var.base_instance_name}"
  region             = "${var.region}"
  target_size        = 3

  named_port {
    name = "http"
    port = 80
  }

  named_port {
    name = "https"
    port = 443
  }

  auto_healing_policies {
    health_check      = "${google_compute_http_health_check.default.self_link}"
    initial_delay_sec = 300
  }
}
#
# Template creation
resource "google_compute_instance_template" "cit" {
  name_prefix = "${var.prefix}"
  description = "${var.desc}"
  project = "${var.project}"
  region  = "${var.region}"
  tags = ["${var.tags}"]
  instance_description = "${var.desc_inst}"
  machine_type = "${var.machine_type}"
  can_ip_forward = false // Whether to allow sending and receiving of packets with non-matching source or destination IPs. This defaults to false.

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

  metadata {
    startup-script = <<SCRIPT
    INT_IP="$(ip route get 8.8.8.8 | awk '{print $NF; exit}')"
    EXT_IP="$(curl -s ipinfo.io/ip)"
    sudo cat <<EOF > /var/www/html/index.html
    <html>
    <body>
    <title>Apache Server - $(hostname)</title>
    <img src="https://cloud.google.com/_static/9abbcf9aa7/images/cloud/gcp-logo.svg" alt="Google Cloud" height="51" width="400"><br><br>
    <img src="https://www.datocms-assets.com/2885/1506457192-blog-packer-list.svg" alt="Packer" height="100" width="100">
    <img src="https://www.datocms-assets.com/2885/1506457071-blog-terraform-list.svg" alt="Terraform" height="100" width="100">
    <img src="https://blog-en.openalfa.com/iconos/logos/apache_httpd.jpg" alt="Apache" height="100" width="100">
    <p><b>Hostname:</b> $(hostname)<br><b>Internal IP:</b> $INT_IP<br><b>External IP:</b> $EXT_IP</p>
    <p>A <b>Packer</b> built, <b>Terraform</b> deployed, <b>GCP</b> Auto Scalling, Managed Instance Group with Load Balancer serving <b>Apache Web Server</b></p>
    </body>
    </html>
SCRIPT
  }

  network_interface {
    network = "${var.network}"
    #
    # Give a Public IP to instance(s)
    #access_config {
    #  // Ephemeral IP
    #}
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
#
# Compute Healthcheck
resource "google_compute_health_check" "default" {
  name               = "${var.hc_name}"
  check_interval_sec = 1
  timeout_sec        = 1

  tcp_health_check {
    port = "${var.hc_port}"
  }
}
#
# Regional MIG AutoScaler
resource "google_compute_region_autoscaler" "cras" {
  name   = "${var.rmig_as_name}"
  region = "${var.region}"
  target = "${google_compute_region_instance_group_manager.rmig.self_link}"

  autoscaling_policy = {
    max_replicas    = 5
    min_replicas    = 3
    cooldown_period = 60
    cpu_utilization {
      target = 0.5
    }
  }
}
#
# Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "gfr" {
  name       = "${var.gfr_name}"
  target     = "${google_compute_target_http_proxy.thp.self_link}"
  port_range = "${var.gfr_portrange}"
}
resource "google_compute_target_http_proxy" "thp" {
  name        = "${var.thp_name}"
  url_map     = "${google_compute_url_map.urlmap.self_link}"
}
resource "google_compute_url_map" "urlmap" {
  name            = "${var.urlmap_name}"
  default_service = "${google_compute_backend_service.rbs.self_link}"

  #host_rule {
  #  hosts        = ["mysite.com"]
  #  path_matcher = "allpaths"
  #}

  #path_matcher {
  #  name            = "allpaths"
  #  default_service = "${google_compute_backend_service.rbs.self_link}"

  #  path_rule {
  #    paths   = ["/*"]
  #    service = "${google_compute_backend_service.rbs.self_link}"
  #  }
  #}
}
