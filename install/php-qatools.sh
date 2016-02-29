#!/bin/bash

# install latest composer
echo "installing composer..."
curl -# -L https://getcomposer.org/installer | php &> /dev/null
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

# install latest phpmd
echo "installing phpmd..."
curl -# -L -o /usr/local/bin/phpmd http://static.phpmd.org/php/latest/phpmd.phar
chmod +x /usr/local/bin/phpmd

# install latest phpcs
echo "installing phpcs..."
curl -# -L -o /usr/local/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
chmod +x /usr/local/bin/phpcs

echo "installing phpcbf..."
curl -# -L -o /usr/local/bin/phpcbf https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
chmod +x /usr/local/bin/phpcbf

# install latest phploc
echo "installing phploc..."
curl -# -L -o /usr/local/bin/phploc https://phar.phpunit.de/phploc.phar
chmod +x /usr/local/bin/phploc

# install latest pdepend
echo "installing pdepend..."
curl -# -L -o /usr/local/bin/pdepend http://static.pdepend.org/php/latest/pdepend.phar
chmod +x /usr/local/bin/pdepend

# install latest phpcpd
echo "installing phpcpd..."
curl -# -L -o /usr/local/bin/phpcpd https://phar.phpunit.de/phpcpd.phar
chmod +x /usr/local/bin/phpcpd

# install latest phpmetrics
echo "installing phpmetrics..."
curl -# -L -o /usr/local/bin/phpmetrics https://github.com/phpmetrics/PhpMetrics/raw/master/build/phpmetrics.phar
chmod +x /usr/local/bin/phpmetrics

# install latest phpdox
echo "installing phpdox..."
curl -# -L -o /usr/local/bin/phpdox https://github.com/theseer/phpdox/releases/download/0.8.1.1/phpdox-0.8.1.1.phar
chmod +x /usr/local/bin/phpdox

# install latest phpunit
echo "installing phpunit..."
curl -# -L -o /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar
chmod +x /usr/local/bin/phpunit

# install latest codeception
echo "installing codeception..."
curl -# -L -o /usr/local/bin/codecept http://codeception.com/codecept.phar
chmod +x /usr/local/bin/codecept
