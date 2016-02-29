#!/usr/bin/dumb-init /bin/bash

if [ ! -f /.initialized ]; then
  # generate nginx certs
  if [ ! -f /etc/ssl/nginx/nginx.key ]; then
    mkdir -p /etc/ssl/nginx
    openssl req -x509 -newkey rsa:4086 \
      -subj "/C=XX/ST=XXXX/L=XXXX/O=XXXX/CN=localhost" \
      -days 3650 -nodes -sha256 \
      -keyout /etc/ssl/nginx/nginx.key -out /etc/ssl/nginx/nginx.crt
    # openssl dhparam -out /etc/ssl/nginx/dhparam.pem 2048
  fi

  # if ini with all extensions is missing (due to mount), create it but comment out all extensions; should be explicitly used when mounting
  if [ ! -f /usr/local/php/etc/conf.d/installed-extensions.ini ]; then
    /install/php-extensions-ini.sh
    sed -i -e 's/^/;/g' $(php-config --prefix)/etc/conf.d/installed-extensions.ini
  fi

  # disable pthreads since php-fpm will crash otherwise
  sed -i -e '/pthreads/d' $(php-config --prefix)/etc/conf.d/installed-extensions.ini

  # move configs
  mkdir -p /var/log/nginx
  chown -R www-data:www-data /var/log/nginx
  rm -rf /etc/nginx/nginx.conf
  rm -rf /etc/nginx/conf.d/default.conf
  cp /run/nginx.conf /etc/nginx/nginx.conf
  cp /run/nginx.default.conf /etc/nginx/conf.d/default.conf
  cp /run/php-fpm.conf $(php-config --prefix)/etc/php-fpm.conf
  :>$(php-config --prefix)/etc/php-fpm.d/dummy.conf
  cp /run/php.ini $(php-config --prefix)/etc/php.ini

  # install latest versions of php qa tools
  if [ ! -z $UPDATE_QATOOLS ]; then
    /install/php-qatools.sh
  fi

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
