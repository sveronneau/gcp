Quick pipeline to make a golden Debian image via Packer (binary stored in gcr.io)

PACKER IMAGE

To use Packer from Google Cloud Build, you need to build an image with Packer installed. Thankfully, one already exists for you to use - you just need to add it to your project.

Clone the cloud-builders-community repo:

$ git clone https://github.com/GoogleCloudPlatform/cloud-builders-community

Go to the directory that has the source code for the packer Docker image:

$ cd cloud-builders-community/packer
Build the Docker image via Cloud Build:

$ gcloud builds submit --config cloudbuild.yaml .
Remove this temporary directory:

$ cd ../.. && rm -rf cloud-builders-community
