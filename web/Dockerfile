FROM php:7.4-fpm-alpine

MAINTAINER Dmitry Khomutov <poisoncorpsee@gmail.com>

ENV PHPCENSOR_VERSION=master

WORKDIR /var/www/html

RUN apk add --no-cache $PHPIZE_DEPS && \
    apk update && \
    apk add git nginx openssh postgresql-dev openldap-dev gettext zlib-dev libzip-dev && \
    pecl install xdebug-2.9.8 && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer

RUN docker-php-ext-install -j$(grep -c ^processor /proc/cpuinfo) pdo pdo_mysql pdo_pgsql ldap zip bcmath && \
    docker-php-ext-enable xdebug

RUN git clone -b $PHPCENSOR_VERSION --single-branch --depth 1 https://github.com/php-censor/php-censor.git . && chmod +x ./bin/console

RUN composer install

ADD entrypoint.sh /
ADD config.tmpl.yml /
ADD nginx.conf /etc/nginx/nginx.conf

ENV ADMIN_NAME=admin
ENV ADMIN_EMAIL=admin@php-censor.local
ENV ADMIN_PASSWORD=admin
ENV DB_HOST=localhost
ENV DB_TYPE=mysql
ENV DB_NAME=phpcensor
ENV DB_USER=phpcensor
ENV DB_PASS=changethepass
ENV SITE_URL=http://phpcensor.localhost
ENV BEANSTALK_HOST=localhost
ENV BEANSTALK_QUEUE_NAME=phpcensor

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
