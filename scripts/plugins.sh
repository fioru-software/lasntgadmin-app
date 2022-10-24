#! /bin/sh

runuser -s /bin/sh -c 'wp plugin install $WP_PLUGINS' www-data
runuser -s /bin/sh -c 'wp plugin activate $WP_PLUGINS' www-data
