FROM httpd:2.4

ARG USER_ID

RUN apt update; \
	apt -y install vim curl;

COPY ./etc/apache2/conf/httpd.conf /usr/local/apache2/conf/httpd.conf

RUN curl -sOL https://raw.githubusercontent.com/richardforth/apache2buddy/master/apache2buddy.pl && chmod + apache2buddy.pl && mv apache2buddy.pl /usr/local/bin/apache2buddy;

RUN usermod -u $USER_ID www-data; \
    groupmod -g $USER_ID www-data

