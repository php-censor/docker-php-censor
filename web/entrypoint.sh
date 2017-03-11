#!/bin/sh
set -eo pipefail

wait_for_db() 
{
    while nc -w 2 -v $DB_HOST $DB_PORT < /dev/null > /dev/null 2>&1
    do
      echo "Wait for database"
      sleep 1
    done
}

set_args() {
    LOCAL_DB_HOST=$DB_HOST

    export DB_HOST=$(echo $LOCAL_DB_HOST | awk -F ":" '{ print $1 }')
    export DB_PORT=$(echo $LOCAL_DB_HOST | awk -F ":" '{ if (ENVIRON["DB_PORT"] != "") print ENVIRON["DB_PORT"]; else $2 }')
}

set_args

[ ! -f ./app/config.yml ] && envsubst < /config.tmpl.yml > ./app/config.yml

wait_for_db

./bin/console php-censor:install --config-from-file=yes --admin-name=$ADMIN_NAME --admin-password=$ADMIN_PASSWORD --admin-email=$ADMIN_EMAIL

#----Start web------

nginx
php-fpm
