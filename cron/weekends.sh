#! /bin/sh

export COMPOSER_AUTOLOAD_FILEPATH=/var/www/html/vendor/autoload.php

/usr/local/bin/php /usr/local/bin/wp action-scheduler run --path=/var/www/html
