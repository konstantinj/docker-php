#!/bin/bash

if [ -z $INSTALL_BASE ]; then
  exit 1
fi

version_nginx=${VERSION_NGINX:-latest}

if [[ $version_nginx == "latest" ]]; then
  version_nginx=$(git ls-remote --tags https://github.com/nginx/nginx.git | egrep -o 'release-[0-9]*\.[0-9]*\.[0-9]*$' | sort -V | tail -n 1 | cut -d- -f2)
fi

VERSION_NGINX=$version_nginx

if [[ $VERSION_NGINX != *"jessie"* ]]
then
  VERSION_NGINX=${VERSION_NGINX}"-1~jessie"
fi

echo "install"
figlet "nginx"
echo "version $VERSION_NGINX"

apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx">>/etc/apt/sources.list
apt-get update
apt-get install -y ca-certificates nginx=${VERSION_NGINX} gettext-base
