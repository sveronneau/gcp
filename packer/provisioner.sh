#!/bin/bash -x
set -eu -o pipefail

sudo apt-get clean
sudo apt-get update
sudo apt-get upgrade -y

PKGS="build-essential htop nginx"

sudo apt-get install $PKGS -y

sleep 30s

sudo sh -c "echo 'This instance was provisioned by some Packer magic!' > /usr/share/nginx/html/index.html"

