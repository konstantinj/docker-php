#!/bin/bash

mkdir -p /etc/ssl/nginx
openssl req -x509 -newkey rsa:4086 \
  -subj "/C=XX/ST=XXXX/L=XXXX/O=XXXX/CN=localhost" \
  -days 3650 -nodes -sha256 \
  -keyout /etc/ssl/nginx/nginx.key -out /etc/ssl/nginx/nginx.crt
# openssl dhparam -out /etc/ssl/nginx/dhparam.pem 2048
