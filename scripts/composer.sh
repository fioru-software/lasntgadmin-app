#! /bin/bash
runuser -s /bin/sh -c 'composer update --no-cache --no-dev --optimize-autoloader' www-data
runuser -s /bin/sh -c 'composer install --no-cache --no-dev --optimize-autoloader --ignore-platform-reqs' www-data
