#! /bin/sh

export COMPOSER_AUTOLOAD_FILEPATH=/var/www/html/vendor/autoload.php

# the group param requires migration to be run first
/usr/local/bin/php /usr/local/bin/wp action-scheduler run --hooks=action_scheduler/migration_hook --path=/var/www/html
/usr/local/bin/php /usr/local/bin/wp action-scheduler run --group=woocommerce-db-updates --path=/var/www/html
