#! /bin/bash
runuser -s /bin/sh -c 'composer install --no-cache --no-dev --optimize-autoloader' www-data

