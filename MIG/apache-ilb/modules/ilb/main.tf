module "gce-lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google"
  name              = "group-http-lb"
  target_tags       = ["${module.mig1.target_tags}", "${module.mig2.target_tags}"]
  backends          = {
    "0" = [
      { group = "${module.mig1.instance_group}" },
      { group = "${module.mig2.instance_group}" }
    ],
  }
  backend_params    = [
    # health check path, port name, port number, timeout seconds.
    "/,http,80,10"
  ]
}
