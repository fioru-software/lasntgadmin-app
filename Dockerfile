FROM php:7-apache
ARG USER_ID

RUN a2enmod rewrite
RUN apt update; \
    apt install default-mysql-client

RUN docker-php-ext-install mysqli

RUN usermod -u $USER_ID www-data; \
    groupmod -g $USER_ID www-data

RUN chown -R www-data:www-data /var/www
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

USER www-data
WORKDIR /var/www/html
USER root
