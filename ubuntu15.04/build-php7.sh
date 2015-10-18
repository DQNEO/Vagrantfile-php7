#!/bin/bash

set -e

export LC_ALL=C
export PHP_VER=7.0.0RC5
export PHP_PREFIX=/opt/php

sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get install -y build-essential tar make gcc autoconf bison re2c
sudo apt-get install -y libxml2-dev libmcrypt-dev  libpng12-dev
sudo apt-get install -y libcurl4-openssl-dev pkg-config libssl-dev libsslcommon2-dev

test -d ~/src || mkdir ~/src
cd ~/src/

curl --location https://github.com/php/php-src/archive/php-${PHP_VER}.tar.gz -o php-${PHP_VER}.tar.gz
tar xfz php-${PHP_VER}.tar.gz
cd php-src-php-${PHP_VER}/

./buildconf --force
./configure --prefix=${PHP_PREFIX}\
            --enable-mbstring\
            --enable-xml\
            --enable-zip\
            --enable-fpm\
            --enable-ftp\
            --enable-exif\
            --enable-fileinfo\
            --enable-pcntl\
            --enable-pdo\
            --with-curl\
            --with-gd\
            --with-curl\
            --with-openssl\
            --with-mcrypt\
            --with-zlib\
            --with-mysqli=mysqlnd\
            --with-pdo-mysql=mysqlnd\
            --enable-json\
            --enable-phar\
            --enable-cli

make -j 2

sudo make install
