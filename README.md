# WordPress template repo

## Local Docker only

Build images and run WordPress.

```sh
docker-compose build --build-arg USER_ID=$(id -u)
docker-compose up -d
# find container name
docker ps
CONTAINER_NAME=
# shell into container
docker exec -ti -u www-data:www-data $CONTAINER_NAME /bin/bash
docker cp .htaccess $CONTAINER_NAME:/var/www/html/.htaccess
# download wordpress
wp core download 
# create config file
wp config create --dbname=wordpress --dbuser=wordpress --dbpass=secret --dbhost=db --force --skip-check
# install wp
wp core install --url=localhost:8080 --title="LASNTG Admin" --admin_user=admin --admin_email=admin@example.com --admin_password=secret
wp plugin install groups woocommerce advanced-custom-fields user-role-editor --activate
wp theme install storefront --activate
# set permalinks
wp rewrite structure --hard '/%postname%/'
# enable debugging
wp config set --raw WP_DEBUG true
wp config set --raw WP_DEBUG_LOG true
# view debug log
tail -f /var/www/html/wp-content/debug.log
```

- Visit [localhost:8080](http://localhost:8080)
- Visit [localhost:8080/wp-admin](http://localhost:/wp-login.php) as log in with username `admin` and password `secret`.

## Local Docker using Blacknight MySQL db

To access MySQL databases hosted by Blacknight requires enable access from external hosts via [cp.blacknight.com](http://cp.blacknight.com) using credentials available at [bitwarden.veri.ie](https://bitwarden.veri.ie) > Collections > Developers > blacknight.com

Copy WordPress source files using relevant Blacknight ftp details available on [bitwarden.veri.ie](https://bitwarden.veri.ie) > Developers to `./src` folder.

```sh
docker-compose build --build-arg USER_ID=$(id -u)
docker-compose up -d wp
docker cp htaccess $CONTAINER_NAME:/var/www/html/.htaccess
docker exec -ti -u www-data:www-data $CONTAINER_NAME /bin/bash
# confirm db connection
wp option get siteurl
# export db
wp db export --porcelain
# copy db dump to export folder
docker cp $CONTAINER_NAME:/var/www/html/$DUMP_FILE export/
# edit wp-config.php file 
vim wp-config.php
# import db into different wordpress install
wp option get siteurl 
wp db import $DUMPFILE --quiet
wp search-replace --url=https://wildwork.ie 'wildwork.ie' 'staging.wildwork.ie' --recurse-objects --network --skip-columns=guid --skip-tables=wp_users
```

## Deployment

Basic authentication requires absolute path to `.htpasswd` file. 

To view the root path upload `info.php` to host and visit `/info.php`

For staging environment the entire site should be protected by basic auth.
For production environment the `/wp-login.php` path show be protected by basic auth.

Prepend the following to `.htaccess`

## Links

- [Salt](https://api.wordpress.org/secret-key/1.1/salt)
- [Advanced Custom Fields](https://www.advancedcustomfields.com/resources)
- [WooCommerce Developer Resources](https://developer.woocommerce.com/)
- [WooCommerce Storefront Theme](https://woocommerce.com/documentation/themes/storefront/)

