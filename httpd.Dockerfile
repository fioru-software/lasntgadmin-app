FROM apache:2.4

RUN a2enmod rewrite headers remoteip
RUN curl -sOL https://raw.githubusercontent.com/richardforth/apache2buddy/master/apache2buddy.pl && chmod + apache2buddy.pl && mv apache2buddy.pl /usr/local/bin/apache2buddy;

RUN usermod -u $USER_ID www-data; \
    groupmod -g $USER_ID www-data

