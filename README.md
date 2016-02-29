# PHP Docker image (WIP)

[![](https://badge.imagelayers.io/konjak/php:latest.svg)](https://imagelayers.io/?images=konjak/php:latest)

## Features
- builds latest stable PHP version (or define version via VERSION)
- builds with all available extensions; as shared if possible
- builds with ZTS
- includes cli and fpm (no apache); nginx is included for simple development usage
- includes couchbase extension
- includes memcached extension
- includes mongodb extension
- includes redis extension
- includes xdebug extension
- includes pthreads extension
- includes phalcon extension
- includes latest composer, phpmd, phpcs, phpcbf, phploc, pdepend, phpcpd, phpmetrics, phpdox, phpunit, codeception
- uses Debian as base (Ubuntu is too large; Alpine has too many missing packages)
- image is as small as possible; all dev related files are removed
- uses forego to control nginx and php-fpm processes

## Installed versions and more info
Please take a look to */info/installed-libs* for all installed libs incl. version. All installed PHP extensions incl. version are available in */info/installed-php-extensions*.
Also */info* contains all compile-logs and -errors.
See /install/\* and /run/\* for more info :-)

## Exposed ports
- 80: nginx http
- 443: nginx https
- 9000: php-fpm fastcgi

## Volumes
- php conf: /usr/local/php/etc/conf.d
- php-fpm conf: /usr/local/php/etc/php-fpm.d
- nginx conf: /etc/nginx/conf.d
- document root: /usr/share/nginx/html (only mount /usr/share/nginx)

## TODO
- php-fpm starts but can't be killed with CTRL+C
- still a lot compile-warnings; can't be good but seems to work
- compiling phalcon takes too long; need to find out how to compile on multiple cores
