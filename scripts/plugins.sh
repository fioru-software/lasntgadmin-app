#! /bin/sh

runuser -s /bin/sh -c 'wp plugin install $WP_PLUGINS' www-data
runuser -s /bin/sh -c 'wp plugin activate $WP_PLUGINS' www-data

if runuser -s /bin/sh -c 'wp plugin is-installed hyperdb' www-data; then
    runuser -s /bin/sh -c 'ln -s /var/www/html/wp-content/plugins/hyperdb/db.php /var/www/html/wp-content/db.php' www-data
fi
