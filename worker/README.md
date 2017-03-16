# PHPCensor's worker

## Description

PHPCensor's worker.

## How to use

Sample run command (all needed containers like beanstald, webpart and database are in a network):

```
docker network create phpcensor
docker run -d --net=phpcensor -e DB_HOST=db -e DB_USER=phpcensor -e DB_PASS=changeme -e DB_NAME=phpcensor -e BEANSTALK_HOST=beanstalk -e BEANSTALK_QUEUE_NAME=phpcensor ket4yii/php-censor:worker
```

Remeber, this container is worker, you should run database, 
beanstalkd and [web](https://github.com/ket4yii/docker-php-censor/tree/master/worker) to build your projects.

*Also you can install your own dependencies, like php-extensions or composer deps, at start time. See below text for further information.*

### Configuration

There are two ways how to configure phpcensor:

* Pass environment variables in container.  
* Move your config.yml by docker volume in /var/www/html/app/config.yml.  

By environment variables you can configure these values:

```
# All values with $ will be substituted by your environment variables

b8:
  database: servers:
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

You don't have to specify all parameters in worker. Minimal list of params is:

* $DB_HOST
* $DB_USER
* $DB_PASS
* $BEANSTALK_HOST
* $BEANSTALK_QUEUE_NAME
* $DB_TYPE

Default values:

In progress

### Installing and extensions in container

You can install your dependencies from script. Just pass it by docker volume to **/docker-init.d/install.sh**. You can install composer dependencies(e.g. plugins for PHPCensor) or php-extensions by *docker-php-ext-install* script(for further information check [official php docker repo](https://hub.docker.com/_/php/)).

#### Example of install.sh

```
docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
docker-php-ext-install -j$(grep -c ^processor /proc/cpuinfo) gd mysqli 
composer require ket4yii/phpci-deployer-plugin:^1.0
```

