#!/bin/sh
set -eo pipefail

wait_for_external_services()
{
    while ! ( nc -w 2 -v $DB_HOST $DB_PORT < /dev/null && nc -w 2 -v $BEANSTALK_HOST 11300 < /dev/null )
    do
      echo "Wait for db and queue"
    done
}

set_args() {
    LOCAL_DB_HOST=$DB_HOST

    export DB_HOST=$(echo $LOCAL_DB_HOST | awk -F ":" '{ print $1 }')
    export DB_PORT=$(echo $LOCAL_DB_HOST | awk -F ":" '{ if (ENVIRON["DB_PORT"] != "") print ENVIRON["DB_PORT"]; else print $2 }')

    if [[ -z "$DB_PORT" ]]; then
        case "$DB_TYPE" in
            pgsql)
                export DB_PORT=5432
                ;;
            mysql)
                export DB_PORT=3306
                ;;
        esac
    fi
}

set_args

[ ! -f ./app/config.yml ] && envsubst < /config.tmpl.yml > ./app/config.yml

wait_for_external_services

if [ -f /docker-init.d/install.sh ]
then
    echo "Install your dependencies"
    . /docker-init.d/install.sh
    echo "Installing is done."
fi

./bin/console php-censor:worker
