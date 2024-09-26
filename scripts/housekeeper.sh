#! /bin/sh

/usr/local/bin/php /usr/local/bin/wp action-scheduler clean --status=complete,failed,canceled --before='14 days ago' --pause=1 --path=/var/www/html
/usr/local/bin/php /usr/local/bin/wp db optimize --path=/var/www/html
