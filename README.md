# PHP Censor docker image
![Web image stars](https://img.shields.io/docker/stars/phpcensor/php-censor-web.svg)
![Worker image stars](https://img.shields.io/docker/stars/phpcensor/php-censor-worker.svg)
![Web image pulls](https://img.shields.io/docker/pulls/phpcensor/php-censor-web.svg)
![Web image pulls](https://img.shields.io/docker/pulls/phpcensor/php-censor-worker.svg)

## Description

[Docker containers for PHP Censor](https://hub.docker.com/u/phpcensor/) with installed, configured source code 
and dependencies, configurable by envs `config.yml`. It has separated into two containers parts: web and worker for 
better scalability.

See [worker](https://github.com/php-censor/docker-php-censor/tree/master/worker) and 
[web](https://github.com/php-censor/docker-php-censor/tree/master/web) to get information about using. Or you can use 
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
