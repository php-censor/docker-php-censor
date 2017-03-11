#!/bin/sh
set -eo pipefail

wait_for_db() 
{
    while nc -w 2 -v $LOCAL_DB_HOST $LOCAL_DB_PORT < /dev/null 2> /dev/null &>1
    do
      sleep 1;
    done
}

export LOCAL_DB_HOST=$(echo $DB_HOST | awk -F ":" '{ print $1 }')
export LOCAL_DB_PORT=$(echo $DB_HOST | awk -F ":" '{ print $2; }')

[ ! -f ./app/config.yml ] && envsubst < /config.tmpl.yml > ./app/config.yml

wait_for_db

./bin/console php-censor:install --config-from-file=yes --admin-name=$ADMIN_NAME --admin-password=$ADMIN_PASSWORD --admin-email=$ADMIN_EMAIL

#----Start web------

nginx
php-fpm
