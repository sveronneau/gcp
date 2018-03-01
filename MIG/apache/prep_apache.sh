#!/bin/bash -x
set -eu -o pipefail
#
INT_IP="$(ip route get 8.8.8.8 | awk '{print $NF; exit}')"
EXT_IP="$(curl -s ipinfo.io/ip)"
#
sudo cat <<EOF > /var/www/html/index.html
<html>
<body>
<title>Apache Server - $(hostname)</title>
<img src="https://cloud.google.com/_static/9abbcf9aa7/images/cloud/gcp-logo.svg" alt="Google Cloud" height="51" width="400">
<h1>Packer baked Apache Server on GCP</h1>
<p><b>Hostname:</b> $(hostname)</p>
<p><b>Internal IP:</b> $INT_IP</p>
<p><b>External IP:</b> $EXT_IP</p>
<img src="https://blog-en.openalfa.com/iconos/logos/apache_httpd.jpg" alt="Google Cloud" height="100" width="100">
</body>
</html>
EOF
