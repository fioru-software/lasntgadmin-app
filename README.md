# LASNTG Admin 

A custom WordPress and WooCommerce website.

## Deployment

### When adding custom plugins and themes to the app for first time.

Edit `composer.json` and add the repo source to the `repositories` property.

```json
{
    "repositories": [
        {
            "type": "vcs",
            "url":  "git@github.com:fioru-software/lasntgadmin-attendees.git"
        }
    ]
}
```

Require the package

```sh
# staging env
docker run -ti --rm -u www-data:www-data -v $(pwd):/var/www/html -w /var/www/html lasntgadmin-app_wordpress composer require fioru/lasntgadmin-example=^1.0.0@rc

#production env
docker run -ti --rm -u www-data:www-data -v $(pwd):/var/www/html -w /var/www/html lasntgadmin-app_wordpress composer require fioru/lasntgadmin-example=^1.0.0@stable
```

### When updating existing plugins and themes.

Update the `composer.lock` file

```sh
docker run -ti --rm -u www-data:www-data -v $(pwd):/var/www/html -w /var/www/html lasntgadmin-app_wordpress composer update --no-dev
```

### When deploying to staging

```sh
# goto staging branch
git checkout staging
# update staging branch
git pull
# create new feature branch based on staging
git checkout -b cm-feature
# push feature branch to github
git push -u origin cm-feature
```

- Create pull request (PR)
- Merge via Github
- Deploy staging branch via [Jenkins](https://jenkins.veri.ie)
- Test your changes

### When deploying to production

```sh
# goto master branch
git checkout master
# update master branch
git pull
# goto existing feature branch based on staging
git checkout cm-feature
# rebase feature branch on master 
git rebase -i master
# force push feature branch to github
git push -uf cm-feature
```

- Create pull request (PR)
- Merge via Github
- Deploy production branch via [Jenkins](https://jenkins.veri.ie)
- Test your changes

## Local Docker only

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

_NB:_ Create your [GITHUB_TOKEN](https://github.com/settings/tokens/new?scopes=repo,read:packages&description=Install%20packages) so you can install composer packages from our private Github repos.

Build images and run WordPress.

```sh
# NB add your GITHB_TOKEN 
docker-compose build --build-arg USER_ID=$(id -u) --build-arg GITHUB_TOKEN=
# start container
docker-compose up -d wordpress
# view debug log
tail -f /var/www/html/wp-content/debug.log
```

- Visit [localhost:8080](http://localhost:8080)
- Visit [localhost:8080/wp-admin](http://localhost:/wp-login.php) as log in with username `admin` and password `secret`.

If you need to rebuild the Docker image and would like to retain your database, do the following:

```sh
docker-compose stop
docker rm lasntgadmin-app_wordpress_1
docker-compose build --build-arg GITHUB_TOKEN= wordpress
docker-compose up -d wordpress
```

```sh
# query the API
curl -X OPTIONS http://locahost:8080/wp-json/wp/v2 | jq
```

> I highly recommend https://github.com/stedolan/jq for json formatting on the command line

To access the running container

```sh
docker exec -ti -w /var/www/html -u www-data:www-data lasntgadmin-app_wordpress_1 bash
ls -l wp-content/plugins
ls -l wp-content/themes
```

### Kustomize

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
- [WP 2FA – Two-factor authentication for WordPress](https://wordpress.org/plugins/wp-2fa/)
- [OpenID Connect Server](https://github.com/Automattic/wp-openid-connect-server)
