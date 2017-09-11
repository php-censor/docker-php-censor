# PHPCensor web-part

## Description

Web part of PHPCensor with nginx and php-fpm.

## How to use

Sample run command (all needed containers like Beanstald, worker and database are in a network):

```
docker network create phpcensor
docker run -d -p 8080:80 --net=phpcensor -e DB_HOST=db -e DB_USER=phpcensor -e DB_PASS=changeme -e DB_NAME=phpcensor -e SITE_URL=http://phpcensor.local -e BEANSTALK_HOST=beanstalk -e BEANSTALK_QUEUE_NAME=phpcensor ket4yii/php-censor:web
```

Remember, this container is web-part and includes only FPM and Nginx, you should run database, 
Beanstalkd and [workers](https://github.com/ket4yii/docker-php-censor/tree/master/worker) to build your projects.

### Configuration

There are two ways how to configure phpcensor:

* Pass environment variables in container.
* Move your `config.yml` by docker volume in `/var/www/html/app/config.yml`.

By environment variables you can configure these values:

```
# All values with $ will be substituted by your environment variables

b8:
  database:
    servers:
      read:
        - host: $DB_HOST
          port: **Will be taken from $DB_HOST**

      write:
        - host: $DB_HOST
          port: **Will be taken from $DB_HOST**
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

And specify admin user by these variables:

* `ADMIN_NAME` (**default: admin**)
* `ADMIN_PASSWORD` (**default: admin**)
* `ADMIN_EMAIL` (**default: admin@php-censor.local**)

Default values:

In progress
