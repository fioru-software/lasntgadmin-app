FROM php:7-apache

ARG USER_ID
ARG WP_VERSION
ARG WP_LOCALE
ARG ELAVON_CONVERGE_WOO_PLUGIN_URL

RUN a2enmod rewrite
RUN apt update; \
    apt install -y default-mysql-client vim libzip-dev unzip libpng-dev libmagickwand-dev libicu-dev

RUN pecl install --configureoptions='with-imagick="autodetect"' imagick; \
    docker-php-ext-enable imagick

RUN docker-php-ext-install mysqli zip gd intl exif

RUN usermod -u $USER_ID www-data; \
    groupmod -g $USER_ID www-data

RUN chown -R www-data:www-data /var/www; \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp; \
    curl -sfL $(curl -s https://api.github.com/repos/powerman/dockerize/releases/latest | grep -i /dockerize-$(uname -s)-$(uname -m)\" | cut -d\" -f4) | install /dev/stdin /usr/local/bin/dockerize

COPY etc/php/php.ini /usr/local/etc/php/php.ini
COPY --chown=www-data:www-data config/.htaccess config/wp-config.php /var/www/html/
COPY scripts/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*

USER www-data
WORKDIR /var/www/html

RUN wp core download --skip-content --version=$WP_VERSION --locale=$WP_LOCALE --path=/var/www/html; \
    mkdir -p /var/www/html/wp-content/plugins /var/www/html/wp-content/themes

# payment gateway
RUN curl --output /tmp/convergewoocommerce.zip -O $ELAVON_CONVERGE_WOO_PLUGIN_URL; \
    unzip /tmp/convergewoocommerce.zip -d /var/www/html/wp-content/plugins/

USER root

CMD ["sh", "/usr/local/bin/run.sh"]

