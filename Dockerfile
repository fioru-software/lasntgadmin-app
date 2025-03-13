FROM php:8.3-apache

ARG USER_ID
ARG WP_VERSION
ARG WP_LOCALE
ARG GITHUB_TOKEN

RUN a2enmod rewrite headers remoteip
RUN apt update; \
    apt install -y default-mysql-client vim libzip-dev unzip libpng-dev libmagickwand-dev libicu-dev cron git liblzf1 liblzf-dev net-tools python3-distro lynx logrotate

RUN docker-php-ext-install mysqli zip gd intl exif opcache soap

#RUN pecl install --configureoptions='with-imagick="autodetect"' imagick; \
RUN pecl channel-update pecl.php.net; \
	pecl install --configureoptions='enable-apcu-debug="no"' apcu; \
	pecl install igbinary; \    
	pecl install xdebug; \
    pecl install --configureoptions='enable-redis-igbinary="yes" enable-redis-lzf="no" enable-redis-zstd="no" enable-redis-msgpack="no" enable-redis-lz4="no" with-liblz4="/usr"' redis; \
    docker-php-ext-enable apcu redis igbinary opcache xdebug

RUN usermod -u $USER_ID www-data; \
    groupmod -g $USER_ID www-data

RUN curl -sOL https://raw.githubusercontent.com/richardforth/apache2buddy/master/apache2buddy.pl && chmod + apache2buddy.pl && mv apache2buddy.pl /usr/local/bin/apache2buddy;

RUN chown -R www-data:www-data /var/www; \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp; \
    curl -sfL $(curl -s https://api.github.com/repos/powerman/dockerize/releases/latest | grep -i /dockerize-$(uname -s)-$(uname -m)\" | cut -d\" -f4) | install /dev/stdin /usr/local/bin/dockerize

# install composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

COPY etc/php/php.ini /usr/local/etc/php/php.ini
COPY --chown=www-data:www-data composer.json composer.lock config/.htaccess config/wp-config.php /var/www/html/
ADD exports /usr/local/src/exports
COPY scripts/* /usr/local/bin/
COPY cron/* /usr/local/bin/
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

COPY etc/logrotate.d/wordpress /etc/logrotate.d/wordpress

# cron
RUN echo '* * * * * /bin/bash /usr/local/bin/everyminute.sh > /var/log/apache2/cron/everyminute.log 2>&1' > /etc/cron.d/everyminute;\
	echo '* * * * 6,0 /bin/bash /usr/local/bin/weekends.sh > /var/log/apache2/cron/weekends.log 2>&1' >> /etc/cron.d/weekends;\
	echo '* 8-17 * * 1-5 /bin/bash /usr/local/bin/officehours.sh > /var/log/apache2/cron/officehours.log 2>&1' >> /etc/cron.d/officehours;\
	echo '0 1 * * 1 /bin/bash /usr/local/bin/weekly.sh > /var/log/apache2/cron/weekly.log 2>&1' >> /etc/cron.d/weekly;\
	echo '* 23-4 * * 1-5 /bin/bash /usr/local/bin/nights.sh > /var/log/apache2/cron/nights.log 2>&1' >> /etc/cron.d/nights;\
	crontab -u www-data /etc/cron.d/everyminute;\
	crontab -u www-data /etc/cron.d/weekends;\
	crontab -u www-data /etc/cron.d/officehours;\
	crontab -u www-data /etc/cron.d/weekly;\
	crontab -u www-data /etc/cron.d/nights

CMD ["sh", "/usr/local/bin/run.sh"]
