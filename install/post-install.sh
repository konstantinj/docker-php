#!/bin/bash

apt-get purge -y $(cat /install/_dev-packages | tr "\n" " ")
apt-get clean -y
apt-get autoclean -y
apt-get autoremove -y
rm -rf /usr/share/locale/*
rm -rf /var/cache/debconf/*-old
rm -rf /var/lib/apt/lists/*
rm -rf /usr/share/doc/*
rm -rf /var/log/*
rm -rf $INSTALL_BASE/src

dpkg-query --show --showformat='${Package;-30} ${Version;-30} ${Status}\n' | grep installed | grep ^lib | awk '{printf "%-30s %s\n",$1,$2}'>/info/installed-libs
php -r 'foreach (get_loaded_extensions() as $e) { echo "$e\t" . phpversion($e) . "\n"; }' | awk '{printf "%-30s %s\n",$1,$2}'>/info/installed-php-extensions
