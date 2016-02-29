#!/bin/bash

:>/etc/apt/sources.list
echo "deb http://ftp.de.debian.org/debian/ jessie main">>/etc/apt/sources.list
echo "deb-src http://ftp.de.debian.org/debian/ jessie main">>/etc/apt/sources.list
echo "deb http://security.debian.org/ jessie/updates main">>/etc/apt/sources.list
echo "deb-src http://security.debian.org/ jessie/updates main">>/etc/apt/sources.list
DEBIAN_FRONTEND=noninteractive apt-get update
