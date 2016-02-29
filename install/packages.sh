#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get install -y $(cat /install/*packages | tr "\n" " ")

curl --progress-bar --max-time 60 --retry-max-time 60 --location --output dumb-init.deb https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64.deb
dpkg --install dumb-init.deb
rm -rf dumb-init.deb

ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h
ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so
ln -s /usr/lib/x86_64-linux-gnu/libldap.a /usr/lib/libldap.a
