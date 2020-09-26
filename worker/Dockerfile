FROM php:7.1-alpine

MAINTAINER Dmitry Khomutov <poisoncorpsee@gmail.com>

ENV PHPCENSOR_VERSION=1.2.1

WORKDIR /var/www/html

RUN apk add --no-cache $PHPIZE_DEPS && \
    apk update && \
    apk add git openssh postgresql-dev gettext zlib-dev && \
    pecl install xdebug-2.5.0 && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer

RUN docker-php-ext-install -j$(grep -c ^processor /proc/cpuinfo) pdo pdo_mysql pdo_pgsql zip bcmath && \
    docker-php-ext-enable xdebug

RUN git clone -b $PHPCENSOR_VERSION --single-branch --depth 1 https://github.com/php-censor/php-censor.git .

RUN composer install

ADD entrypoint.sh /
ADD config.tmpl.yml /

ENV DB_HOST=localhost
ENV DB_TYPE=mysql
ENV DB_NAME=phpcensor
ENV DB_USER=phpcensor
ENV DB_PASS=changethepass
ENV BEANSTALK_HOST=beanstalk
ENV BEANSTALK_QUEUE_NAME=phpcensor

ENTRYPOINT ["/entrypoint.sh"]
