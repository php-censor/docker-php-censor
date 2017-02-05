#!/bin/sh
set -eo pipefail

export LOCAL_DB_HOST=$(echo $DB_HOST | awk -F ":" '{ print $1 }')
export LOCAL_DB_PORT=$(echo $DB_HOST | awk -F ":" '{ print $2; }')

[ ! -f ./app/config.yml ] && envsubst < /config.tmpl.yml > ./app/config.yml
./bin/console php-censor:install --config-from-file=yes --admin-name=$ADMIN_NAME --admin-password=$ADMIN_PASSWORD --admin-email=$ADMIN_EMAIL
nginx
php-fpm
