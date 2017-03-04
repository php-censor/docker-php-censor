# PHP Censor docker image
![Image stars](https://img.shields.io/docker/stars/ket4yii/php-censor.svg)
![Image pulls](https://img.shields.io/docker/pulls/ket4yii/php-censor.svg)

## Description

[Docker containers for PHP Censor](https://hub.docker.com/r/ket4yii/php-censor/) with installed, configured source code 
and dependencies, configurable by envs config.yml. It has separated into two containers parts: web and worker for 
better scalability.

See [worker](https://github.com/ket4yii/docker-php-censor/tree/master/worker) and 
[web](https://github.com/ket4yii/docker-php-censor/tree/master/web) to get information about using. Or you can use 
docker-compose file that is described below to run a whole stack.

## Docker compose

You can run PHP Censor docker containers by command:

```bash
cd /path/to/docker-php-censor

# For run PHP Censor with PostgreSQL database
docker-compose up

# For run PHP Censor with MySQL database
docker-compose -f docker-compose.yml -f docker-compose.mysql.yml up

```

### Requirements

Used `docker-compose.yml` v2.1, which requires:

* Docker Engine v1.12+
* Docker Compose v1.9+
