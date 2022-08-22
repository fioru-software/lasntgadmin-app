# WordPress template repo

## Local Docker only

Create `.env` file

```
SITE_URL=localhost:8080
SITE_TITLE=LASNTG
WP_PLUGINS=groups woocommerce advanced-custom-fields user-role-editor
WP_THEME=twentytwentytwo
ADMIN_USERNAME=admin
ADMIN_PASSWORD=secret
ADMIN_EMAIL=lasntg@example.com
```

Build images and run WordPress.


```sh
# build image. 
# override Dockerfile ARG's by appending --build-arg USER_ID=1000 to command
docker-compose build
# start container
docker-compose up -d
# view debug log
tail -f /var/www/html/wp-content/debug.log
```

- Visit [localhost:8080](http://localhost:8080)
- Visit [localhost:8080/wp-admin](http://localhost:/wp-login.php) as log in with username `admin` and password `secret`.

```sh
# query the API
curl -X OPTIONS http://locahost:8080/wp-json/wp/v2 | jq
```

> I highly recommend https://github.com/stedolan/jq for json formatting on the command line

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

### Blacknight

Basic authentication requires absolute path to `.htpasswd` file. 

To view the root path upload `info.php` to host and visit `/info.php`

For staging environment the entire site should be protected by basic auth.
For production environment the `/wp-login.php` path show be protected by basic auth.

Prepend the following to `.htaccess`

### Gcloud

```sh
kubectl kustomize deployment/k8s/configmaps/staging/
kubectl apply -k deployment/k8s/configmaps/staging/

kubectl kustomize deployment/k8s/secrets/staging/
kubectl apply -k deployment/k8s/secrets/staging/
```


## Links

- [Salt](https://api.wordpress.org/secret-key/1.1/salt)
- [Advanced Custom Fields](https://www.advancedcustomfields.com/resources)
- [WooCommerce Developer Resources](https://developer.woocommerce.com/)
- [WooCommerce Storefront Theme](https://woocommerce.com/documentation/themes/storefront/)

