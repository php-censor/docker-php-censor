# PHPCensor docker image

## Description

Docker container for PHPCensor with installed, configured source code 
and dependencies, configurable by envs config.yml and php-fpm as entrypoint.

## How to use

Sample run command (all needed containers like beanstald, database and webserver are in a network):

```
docker network create phpcensor
docker run -d -p 9000:9000 --net=phpcensor -e DB_HOST=db -e DB_USER=phpcensor -e DB_PASS=changeme -e DB_NAME=phpcensor -e SITE_URL=http://phpcensor.local -e BEANSTALK_HOST=beanstalk -e BEANSTALK_QUEUE_NAME=phpcensor # Port exposing is not necessary you can just add container to webserver/beanstalkd containers network(or link it)
```

Remeber, this container includes only FPM, you should run database, 
beanstalkd, webserver and workers to use it(you can see how to configure webserver [here](https://github.com/corpsee/php-censor/blob/master/docs/en/virtual_host.md)). Also you can use docker-compose file which will be described below.

### Configuration

There are two ways to configure phpcensor:

* Pass environment variables in container.
* Move your config.yml by docker volume in /var/www/html/app.

By environment variables you can configure these values:

```
# All values with $ will be substituted by your environment variables

b8:
  database:
    servers:
      read:
        - host: $LOCAL_DB_HOST
          port: $DB_PORT
      write:
        - host: $LOCAL_DB_HOST
          port: $DB_PORT
    type: $DB_TYPE
    name: $DB_NAME
    username: $DB_USERNAME
    password: $DB_PASSWORD
php-censor:
  language: en
  per_page: 10
  url:      '$SITE_URL'
  email_settings:
    from_address: $SMTP_FROM
    smtp_address: $SMTP_HOST
    smtp_port: $SMTP_PORT
    smtp_username: $SMTP_USER
    smtp_password: $SMTP_PASSWORD
    from_address: $SMTP_FROM
    default_mailto_address: $SMTP_DEFAULTTO
    smtp_encryption: $SMTP_ENCRYPT
  queue:
    host: $BEANSTALK_HOST
    name: $BEANSTALK_QUEUE_NAME
    lifetime: 600
  github:
    token: $GITHUB_TOKEN
    comments:
      commit: false
      pull_request: false
  build:
    remove_builds: true
  security:
    disable_auth: false
    default_user_id: 1
    auth_providers:
      internal:
        type: internal
      ldap:
        type: ldap
        data:
          host: $LDAP_HOST
          port: $LDAP_PORT
          base_dn: $LDAP_BASE_DN
          mail_attribute: $LDAP_MAIL_ATTRIBUTE

``` 

### Docker compose

In progress
