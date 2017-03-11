#!/bin/sh
set -eo pipefail

# Check external services (db, queue) on ready
wait_for_external_services() {
    local BEANSTALK_DEFAULT_PORT="11300"

    while ! ( nc -w 2 -v "$DB_HOST" "$DB_PORT" < /dev/null && nc -w 2 -v "$BEANSTALK_HOST" $BEANSTALK_DEFAULT_PORT < /dev/null )
    do
      echo "Wait for db and queue"
    done
}

# Process DB args and set it to global
parse_args() {
    local NON_PARSED_DB_HOST=$DB_HOST

    export DB_HOST=$(echo "$NON_PARSED_DB_HOST" | awk -F ":" '{ print $1 }')
    export DB_PORT=$(echo "$NON_PARSED_DB_HOST" | awk -F ":" '{ if (ENVIRON["DB_PORT"] != "") print ENVIRON["DB_PORT"]; else print $2 }')

    if [ -z "$DB_PORT" ]; then
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

# Entrypoint
main() {
    parse_args
    
    if [ ! -f ./app/config.yml ]; then
        envsubst < /config.tmpl.yml > ./app/config.yml
    fi
    
    wait_for_external_services

    if [ -f /docker-init.d/install.sh ]; then
        echo "Install your dependencies..."
        . /docker-init.d/install.sh
        echo "Installing is done."
    fi
    
    ./bin/console php-censor:worker
}

main
