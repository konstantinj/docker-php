#!/bin/bash

if [ -z $INSTALL_BASE ]; then
  exit 1
fi

extension_dir=$(php-config --extension-dir)
config_dir=$(php-config --prefix)/etc/conf.d

# install libcouchbase
cd $INSTALL_BASE/src
version_libcouchbase=$(git ls-remote --tags https://github.com/couchbase/libcouchbase.git | grep -o '[0-9]*\.[0-9]*\.[0-9]*$' | tail -n 1)

echo "install"
figlet "libcouchbase"
echo "version $version_libcouchbase"

curl --progress-bar --max-time 60 --retry-max-time 60 --retry 5 --location https://github.com/couchbase/libcouchbase/archive/${version_libcouchbase}.tar.gz  | tar xzf -
mv libcouchbase* libcouchbase
cd libcouchbase

mkdir build
cd build
../cmake/configure --prefix=/usr
make -j$(nproc) > >(tee /info/compile-libcouchbase.log) 2> >(tee /info/compile-libcouchbase.err >&2)
make install

# install php-couchbase
cd $INSTALL_BASE/src
branch_couchbase="php7"

echo "install"
figlet "php-couchbase"
echo "from $branch_couchbase branch"

git clone https://github.com/couchbase/php-couchbase.git --branch $branch_couchbase --single-branch
cd php-couchbase

phpize
./configure --enable-couchbase
make -j$(nproc) > >(tee /info/compile-php-couchbase.log) 2> >(tee /info/compile-php-couchbase.err >&2)
cp modules/couchbase.so $extension_dir/couchbase.so
