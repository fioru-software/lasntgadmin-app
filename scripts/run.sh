#! /bin/sh

set -e

dockerize -timeout 300s -wait tcp://$DB_HOST:3306 

if ! wp core is-installed; then
    runuser -s /bin/bash -c "wp core install --url=$SITE_URL --title='$SITE_TITLE' --admin_user=$ADMIN_USERNAME --admin_email=$ADMIN_EMAIL --admin_password=$ADMIN_PASSWORD" www-data
    runuser -s /bin/bash -c "wp plugin install $WP_PLUGINS --activate" www-data
    runuser -s /bin/bash -c "wp theme install $WP_THEME --activate" www-data
    runuser -s /bin/bash -c "wp rewrite structure --hard '/%postname%/'" www-data
fi

apache2-foreground
