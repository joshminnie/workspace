#! /bin/bash

# This script is for installing additional PHP extensions for the PHP 8.1 container. See https://hub.docker.com/_/php for more
# details (Search on page for "How to install more PHP extensions"). I have added a the commands to install both Composer 1 and 2
# for your convenience.

# Install Composer 1 & 2
wget https://getcomposer.org/download/latest-2.x/composer.phar
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer

wget https://getcomposer.org/download/latest-1.x/composer.phar
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer1
