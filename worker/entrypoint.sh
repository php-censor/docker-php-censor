#!/bin/sh
set -eo pipefail

wait_for_db() 
{
    while nc -w 2 -v $LOCAL_DB_HOST $LOCAL_DB_PORT < /dev/null > /dev/null 2>&1
    do
      sleep 10
      echo "Wait for database"
    done
}

set_args() {
    LOCAL_DB_HOST=$DB_HOST

    export DB_HOST=$(echo $LOCAL_DB_HOST | awk -F ":" '{ print $1 }')
    export DB_PORT=$(echo $LOCAL_DB_HOST | awk -F ":" '{ print $2; }')
}

set_args

[ ! -f ./app/config.yml ] && envsubst < /config.tmpl.yml > ./app/config.yml

wait_for_db

if [ -f /docker-init.d/install.sh ]
then
    echo "Install your dependencies"
    . /docker-init.d/install.sh
    echo "Installing is done."
fi

./bin/console php-censor:worker
