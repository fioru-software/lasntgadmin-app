#! /bin/sh

runuser -s /bin/sh -c 'wp theme install $WP_THEMES' www-data
runuser -s /bin/sh -c 'wp theme activate $WP_THEMES' www-data
