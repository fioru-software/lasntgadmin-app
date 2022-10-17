# WordPress template repo

## Local Docker only

### Run WordPress

Create `.env` file

```
SITE_URL=localhost:8080
SITE_TITLE=LASNTG
WP_PLUGINS=groups woocommerce advanced-custom-fields user-role-editor convergewoocommerce wp-mail-smtp
WP_THEMES=storefront
ADMIN_USERNAME=admin
ADMIN_PASSWORD=secret
ADMIN_EMAIL=lasntg@example.com
```

Build images and run WordPress.

Create the [GITHUB_TOKEN](https://github.com/settings/tokens/new?scopes=repo,read:packages&description=Install%20packages)

```sh
# NB add your GITHB_TOKEN 
docker-compose build --build-arg USER_ID=$(id -u) --build-arg GITHUB_TOKEN=
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

## Deployment

### Gcloud

```sh
kubectl kustomize deployment/k8s/configmaps/staging/
kubectl apply -k deployment/k8s/configmaps/staging/

kubectl kustomize deployment/k8s/secrets/staging/
kubectl apply -k deployment/k8s/secrets/staging/
```

```sh
# watch pod
kubectl get pods -o wide -l app=staging-lasntg --watch
# watch pod events
kubectl get event --field-selector involvedObject.name=staging-lasntg-7788ffdbb7-nkn87 --watch
```

## Links

- [Evalon WooCommerce Payment Gateway](https://developer.elavon.com/na/docs/converge/1.0.0/integration-guide/shopping_carts/woocommerce_installation_guide)
- [Salt](https://api.wordpress.org/secret-key/1.1/salt)
- [Advanced Custom Fields](https://www.advancedcustomfields.com/resources)
- [WooCommerce Developer Resources](https://developer.woocommerce.com/)
- [WooCommerce Storefront Theme](https://woocommerce.com/documentation/themes/storefront/)

