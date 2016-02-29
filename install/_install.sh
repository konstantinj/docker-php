#!/bin/bash

export INSTALL_BASE=/usr/local
mkdir -p $INSTALL_BASE/src
mkdir /info

/install/pre-install.sh
/install/packages.sh
/install/nginx.sh
/install/forego.sh
/install/php.sh
/install/php-xdebug.sh
/install/php-pthreads.sh
/install/php-memcached.sh
/install/php-mongodb.sh
/install/php-redis.sh
/install/php-couchbase.sh
/install/php-phalcon.sh
/install/php-extensions-ini.sh
/install/php-qatools.sh
/install/post-install.sh
