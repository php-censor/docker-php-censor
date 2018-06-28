PHP Censor docker images
========================

*Web image (php-censor-web)*

![Web image stars](https://img.shields.io/docker/stars/phpcensor/php-censor-web.svg)
![Web image pulls](https://img.shields.io/docker/pulls/phpcensor/php-censor-web.svg)

*Worker image (php-censor-worker)*

![Worker image stars](https://img.shields.io/docker/stars/phpcensor/php-censor-worker.svg)
![Worker image pulls](https://img.shields.io/docker/pulls/phpcensor/php-censor-worker.svg)

## Description

[Docker containers for PHP Censor](https://hub.docker.com/u/phpcensor/) with installed, configured source code
and dependencies, configurable by environment variables `config.yml`. It has separated into two containers parts:
[php-censor-web](./web/README.md) and [php-censor-worker](./worker/README.md) for better scalability.

You can use docker-compose file (`docker-compose.yml`) that is described below to run a whole stack.

## Docker compose

### How to use

Default way with PostgreSQL database:

```
docker-compose -f docker-compose.yml up -d
```

Or if you want to use it with MySQL (MariaDB):

```
docker-compose -f docker-compose.mysql.yml up -d
```

If you want to up more worker just use this command, when the PHP Censor stack is already started (but you can do it on
start):

```
docker-compose scale worker=4
```

### Requirements

Used `docker-compose.yml` v2.1, which requires:

* Docker Engine v1.12+
* Docker Compose v1.9+
