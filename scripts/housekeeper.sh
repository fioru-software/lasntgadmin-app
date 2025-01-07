#! /bin/sh

export COMPOSER_AUTOLOAD_FILEPATH=/var/www/html/vendor/autoload.php

/usr/local/bin/php /usr/local/bin/wp action-scheduler clean --status=complete,failed,canceled --before='7 days ago' --pause=1 --path=/var/www/html
/usr/local/bin/php /usr/local/bin/wp db optimize --path=/var/www/html
/usr/local/bin/php /usr/local/bin/wp cache flush --path=/var/www/html
