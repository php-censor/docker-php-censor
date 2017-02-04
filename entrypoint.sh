#!/bin/sh
set -eo pipefail

export LOCAL_DB_HOST=$(echo $DB_HOST | awk -F ":" '{ print $1 }')
export LOCAL_DB_PORT=$(echo $DB_HOST | awk -F ":" '{ if ($2 == "") print 3306; else $2; }')

[ ! -f ./app/config.yml ] envsubst < /config.tmpl.yml > ./app/config.yml
./bin/console php-censor:migrate
nginx
php-fpm
