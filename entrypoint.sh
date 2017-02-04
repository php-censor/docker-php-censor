#!/bin/sh

export LOCAL_DB_HOST=$(echo $DB_HOST | awk -F ":" '{ print $1 }')
export DB_PORT=$(echo $DB_HOST | awk -F ":" '{ if ($2 == "") print 3306; else $2; }')

CENSOR_DIR=/var/www/html

envsubst < /config.tmpl.yml > $CENSOR_DIR/app/config.yml
nginx
php-fpm
