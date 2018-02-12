# gcp/gcs-backend
Terraform script sample to enable GCS as a backend for tfstate file.

Make sure you create a bucker prior execution and also activate versioning on that bucket.

* gsutil versioning set on gs://your_terraform_state_bucket

Scripts uses a GCP service account and a JSON file with your account token.

data "terraform_remote_state" "foo" {
  backend = "gcs"
  config {
    bucket  = "terraform-state"
    prefix  = "prod"
  }
}

resource "template_file" "bar" {
  template = "${greeting}"

  vars {
    greeting = "${data.terraform_remote_state.foo.greeting}"
  }
}
