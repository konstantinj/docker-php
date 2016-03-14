#!/bin/bash

mkdir -p /var/log/nginx
chown -R www-data:www-data /var/log/nginx
rm -rf /etc/nginx/nginx.conf
rm -rf /etc/nginx/conf.d/default.conf
cp /run/nginx.conf /etc/nginx/nginx.conf
cp /run/nginx.default.conf /etc/nginx/conf.d/default.conf
cat /run/php.ini $(php-config --prefix)/etc/all-ext.ini>$(php-config --prefix)/etc/php-all-ext.ini
cat /run/php.ini $(php-config --prefix)/etc/all-ext.ini>$(php-config --prefix)/etc/php-no-pthreads.ini
sed -i -e '/pthreads/d' $(php-config --prefix)/etc/php-no-pthreads.ini
cat /run/php.ini $(php-config --prefix)/etc/all-ext.ini>$(php-config --prefix)/etc/php-no-xdebug.ini
sed -i -e '/xdebug/d' $(php-config --prefix)/etc/php-no-xdebug.ini
cp /run/php.ini $(php-config --prefix)/etc/php.ini
cp /run/php-fpm.conf $(php-config --prefix)/etc/php-fpm.conf
:>$(php-config --prefix)/etc/conf.d/dummy.conf
:>$(php-config --prefix)/etc/php-fpm.d/dummy.conf
echo "<?php phpinfo();">/usr/share/nginx/html/info.php
