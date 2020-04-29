Quick pipeline to make a golden image via Packer (binary stored in gcr.io)

PACKER IMAGE

To use Packer from Google Cloud Build, you need to build an image with Packer installed.

From CLOUD SHELL or your local SDK

Clone this repo:<br>
$ git clone https://github.com/sveronneau/gcp

Go to the directory that has the source code for the packer Docker image:<br>
$ cd gcp/cloudbuild-packer

Build the Docker image via Cloud Build:<br>
$ gcloud builds submit --config cloudbuild.yaml .

This builds the Docker image with packer in it and stores it in GCR.io.  Your next step is to go in the GCE folder and actually create a build trigger that will create the Golden Image.
