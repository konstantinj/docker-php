#!/usr/bin/dumb-init /bin/bash

if [ ! -f /.initialized ]; then
  /run/certs.sh
  /run/configs.sh

  touch /.initialized
fi

figlet "php $(php-config --version)"
php -v
nginx -v
printf "\n"
printf "%20s: %s\n" "php ini conf path" "/usr/local/php/etc/conf.d"
printf "%20s: %s\n" "php-fpm conf path" "/usr/local/php/etc/php-fpm.d"
printf "%20s: %s\n" "nginx conf path" "/etc/nginx/conf.d"
printf "%20s: %s\n" "document root" "/usr/share/nginx/html"
printf "%20s  %s\n" "" "set volumes appropriately"
printf "\n"

forego start -f /run/Procfile
