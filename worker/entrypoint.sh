#!/bin/sh
set -eo pipefail

export LOCAL_DB_HOST=$(echo $DB_HOST | awk -F ":" '{ print $1 }')
export LOCAL_DB_PORT=$(echo $DB_HOST | awk -F ":" '{ print $2; }')

[ ! -f ./app/config.yml ] && envsubst < /config.tmpl.yml > ./app/config.yml

if [ -f /docker-init.d/install.sh ]
then
    echo "Install your dependencies"
    . /docker-init.d/install.sh
    echo "Installing is done."
fi

./bin/console php-censor:worker
