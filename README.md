# PHP Censor docker image
![Image stars](https://img.shields.io/docker/stars/ket4yii/php-censor.svg)
![Image pulls](https://img.shields.io/docker/pulls/ket4yii/php-censor.svg)

## Description

[Docker containers for PHP Censor](https://hub.docker.com/r/ket4yii/php-censor/) with installed, configured source code 
and dependencies, configurable by envs `config.yml`. It has separated into two containers parts: web and worker for 
better scalability.

See [worker](https://github.com/ket4yii/docker-php-censor/tree/master/worker) and 
[web](https://github.com/ket4yii/docker-php-censor/tree/master/web) to get information about using. Or you can use 
docker-compose file that is described below to run a whole stack.

## Docker compose

### How to use

Default way with Postgresql database:

```
docker-compose up -d
```

Or if you want to use it with Mysql (Mariadb):

```
docker-compose -f docker-compose.mysql.yml -d
```

If you want to up more worker just use this command, when the phpcensor stack is already started (but you can do it on 
start):

```
docker-compose scale worker=4
```

### Requirements

Used `docker-compose.yml` v2.1, which requires:

* Docker Engine v1.12+
* Docker Compose v1.9+
