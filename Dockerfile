FROM php:7-apache

ARG USER_ID
ARG WP_VERSION
ARG WP_LOCALE
ARG GITHUB_TOKEN
ARG COMPOSER_MINIMUM_STABILITY

RUN a2enmod rewrite
RUN apt update; \
    apt install -y default-mysql-client vim libzip-dev unzip libpng-dev libmagickwand-dev libicu-dev cron php-soap

RUN pecl install --configureoptions='with-imagick="autodetect"' imagick; \
    docker-php-ext-enable imagick

RUN docker-php-ext-install mysqli zip gd intl exif opcache

RUN usermod -u $USER_ID www-data; \
    groupmod -g $USER_ID www-data

RUN chown -R www-data:www-data /var/www; \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp; \
    curl -sfL $(curl -s https://api.github.com/repos/powerman/dockerize/releases/latest | grep -i /dockerize-$(uname -s)-$(uname -m)\" | cut -d\" -f4) | install /dev/stdin /usr/local/bin/dockerize

# install composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

COPY etc/php/php.ini /usr/local/etc/php/php.ini
COPY --chown=www-data:www-data composer.json composer.lock config/.htaccess config/wp-config.php /var/www/html/
ADD exports /usr/local/src/exports
COPY scripts/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*

USER www-data
WORKDIR /var/www/html

RUN wp core download --skip-content --version=$WP_VERSION --locale=$WP_LOCALE --path=/var/www/html; \
    mkdir -p /var/www/html/wp-content/plugins /var/www/html/wp-content/themes

USER www-data
RUN composer config --auth github-oauth.github.com ${GITHUB_TOKEN}; \
    composer config --no-plugins allow-plugins.composer/installers true

# plugins
RUN mkdir /tmp/plugins
COPY --chown=www-data:www-data plugins/* /tmp/plugins/
RUN for plugin in /tmp/plugins/*.zip; do unzip -uq $plugin -d /var/www/html/wp-content/plugins/; done;

USER root

# cron
RUN echo '* * * * * /bin/bash /usr/local/bin/cron.sh > /var/log/apache2/cron.log 2>&1' > /etc/cron.d/wordpress;\
    crontab -u www-data /etc/cron.d/wordpress

CMD ["sh", "/usr/local/bin/run.sh"]

