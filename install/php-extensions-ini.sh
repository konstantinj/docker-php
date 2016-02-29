#!/bin/bash

extension_dir=$(php-config --extension-dir)
conf_dir=$(php-config --prefix)/etc/conf.d
:>$conf_dir/installed-extensions.ini
for f in $extension_dir/*.so; do
  f=$(basename $f)
  if [[ $f == "opcache.so" ]] || [[ $f == "xdebug.so" ]]; then
    echo "zend_extension=$f">>$conf_dir/installed-extensions.ini
  else
    echo "extension=$f">>$conf_dir/installed-extensions.ini
  fi
done
