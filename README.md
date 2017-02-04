# PHPCensor docker image
![Image stars](https://img.shields.io/docker/stars/ket4yii/php-censor.svg)
![Image pulls](https://img.shields.io/docker/pulls/ket4yii/php-censor.svg)

## Description

[Docker container for PHPCensor](https://hub.docker.com/r/ket4yii/php-censor/) with installed, configured source code 
and dependencies, configurable by envs config.yml and nginx with fpm.

## How to use

Sample run command (all needed containers like beanstald, worker and database are in a network):

```
docker network create phpcensor
docker run -d -p 8080:80 --net=phpcensor -e DB_HOST=db -e DB_USER=phpcensor -e DB_PASS=changeme -e DB_NAME=phpcensor -e SITE_URL=http://phpcensor.local -e BEANSTALK_HOST=beanstalk -e BEANSTALK_QUEUE_NAME=phpcensor ket4yii/php-censor
```

Remeber, this container includes only FPM and nginx, you should run database, 
beanstalkd and workers to use it. Also you can use docker-compose file which will be described below.

### Configuration

There are two ways to configure phpcensor:

* Pass environment variables in container.
* Move your config.yml by docker volume in /var/www/html/app/config.yml.

By environment variables you can configure these values:

```
# All values with $ will be substituted by your environment variables

b8:
  database:
    servers:
      read:
        - host: $DB_HOST
          port: $DB_PORT
      write:
        - host: $DB_HOST
          port: $DB_PORT
    type: $DB_TYPE
    name: $DB_NAME
    username: $DB_USER
    password: $DB_PASS
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
