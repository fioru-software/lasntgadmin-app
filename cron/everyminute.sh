#! /bin/sh

export COMPOSER_AUTOLOAD_FILEPATH=/var/www/html/vendor/autoload.php

/usr/local/bin/php /usr/local/bin/wp action-scheduler run --batches=1 --batch-size=1 --group=woocommerce-db-updates --path=/var/www/html
