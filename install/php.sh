#!/bin/bash

if [ -z $INSTALL_BASE ]; then
  exit 1
fi

version=${VERSION:-latest}

if [[ $version == "latest" ]]; then
  version=$(git ls-remote --tags https://github.com/php/php-src | grep -o 'php-[0-9]\.[0-9]\.[0-9]$' | tail -n 1 | cut -d- -f2)
fi

install_path=$INSTALL_BASE/php-$version
mkdir -p $install_path

echo "install"
figlet "php"
echo "version $version"

cd $INSTALL_BASE/src

curl --progress-bar --max-time 60 --retry-max-time 60 --retry 5 --location https://github.com/php/php-src/archive/php-${version}.tar.gz | tar xzf -

mv php* php
cd php

./buildconf --force

./configure \
--prefix=$install_path \
--exec-prefix=$install_path \
--disable-debug \
--disable-rpath \
--disable-cgi \
--enable-maintainer-zts \
--enable-fpm \
--enable-phpdbg=shared \
--enable-phpdbg-webhelper=shared \
--enable-dtrace=shared \
--enable-bcmath=shared \
--enable-calendar=shared \
--enable-dba=shared \
--enable-exif=shared \
--enable-ftp=shared \
--enable-gd-native-ttf=shared \
--enable-intl=shared \
--enable-mbstring=shared \
--enable-pcntl=shared \
--enable-shmop=shared \
--enable-soap=shared \
--enable-sockets=shared \
--enable-sysvmsg=shared \
--enable-sysvsem=shared \
--enable-sysvshm=shared \
--enable-wddx=shared \
--enable-zip=shared \
--enable-mysqlnd=shared \
--enable-zend-signals \
--with-fpm-user=www-data \
--with-fpm-group=www-data \
--with-layout=GNU \
--with-config-file-path=$install_path/etc \
--with-config-file-scan-dir=$install_path/etc/conf.d \
--with-openssl \
--with-pcre-regex \
--with-zlib=shared \
--with-bz2=shared \
--with-curl \
--with-enchant=shared \
--with-gd=shared \
--with-gettext=shared \
--with-gmp=shared \
--with-mhash=shared \
--with-imap=shared \
--with-kerberos \
--with-imap-ssl=shared \
--with-ldap=shared \
--with-mcrypt=shared \
--with-mysqli=shared \
--with-pdo-mysql=shared \
--with-pdo-pgsql=shared \
--with-pgsql=shared \
--with-pspell=shared \
--with-tidy=shared \
--with-xmlrpc=shared \
--with-xsl=shared \
--with-gnu-ld \
--with-pic \
--without-pear

# --with-readline=shared \
# --with-snmp=shared \

make -j$(nproc) > >(tee /info/compile-${PWD##*/}.log) 2> >(tee /info/compile-${PWD##*/}.err >&2)
# make test
make install

mkdir $install_path/etc/conf.d
cp php.ini-production $install_path/etc/
cp php.ini-development $install_path/etc/
ln -s $install_path $INSTALL_BASE/php
ln -s $INSTALL_BASE/php/bin/php /usr/local/bin/php
ln -s $INSTALL_BASE/php/bin/php-config /usr/local/bin/php-config
ln -s $INSTALL_BASE/php/bin/phpdbg /usr/local/bin/phpdbg
ln -s $INSTALL_BASE/php/bin/phpize /usr/local/bin/phpize
ln -s $INSTALL_BASE/php/sbin/php-fpm /usr/local/sbin/php-fpm
