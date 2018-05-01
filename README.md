# Dockerize YOURLS - Your Own URL Shortener

[![Docker Stars](https://img.shields.io/docker/stars/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)
[![Docker Pulls](https://img.shields.io/docker/pulls/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)
[![Docker Automated](https://img.shields.io/docker/automated/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)


## Integrated Items

* [Yourls](http://yourls.org) - 1.7.2


## Integrated Plugins

* [302-instead](https://github.com/timcrockford/302-instead)
* [dont-track-admins](https://github.com/dgw/yourls-dont-track-admins)
* [fallback_url_config](http://diegopeinador.com/fallback-url-yourls-plugin)
* [force-lowercase](https://github.com/YOURLS/force-lowercase)
* [mobile-detect](https://github.com/guessi/yourls-mobile-detect)
* [dont-log-bots](https://github.com/YOURLS/dont-log-bots)
* [dont-log-crawler](https://github.com/luixxiul/dont-log-crawlers)
* [dont-log-health-checker](https://github.com/guessi/yourls-dont-log-health-checker)


## Usage

To run YOURLS service with customized config

    $ vim env.mysql
    $ vim env.yourls
    $ docker-compose up [--build]


## Dashboard

* Default Login Page: http://localhost/admin/index.php
* Default Username: **see env.yourls**
* Default Password: **see env.yourls**


## Advanced

### Create database backup

Execute `backup.sh` to get regular backup


### Restore backup from backup file

Make sure there is no container running

    $ docker-compose down
    $ docker ps

Cleanup volumes/var/lib/mysql/*

    $ rm -vrf volumes/var/lib/mysql/*

Make sure there is no sql file under volums/docker-entrypoint-initdb.d/

    $ ls -l volumes/docker-entrypoint-initdb.d/

Move the backup sql file to volumes/docker-entrypoint-initdb.d/

    $ cp mysql-dump-YYYYMMDD-hhmmss.sql volumes/docker-entrypoint-initdb.d/
    $ docker-compose up [--build]


## FAQ

### How can I use non-default password or variables?

    simply modify the variable configures in `env.*` before run


## Known Issue

WebUI may show `Could not write file .htaccess in YOURLS root directory.`
at first time deployment, it is actually a **false alarm**, please ignore it.

WebUI may show `Could not auto-encrypt passwords.` when log into admin page,
it is Docker specific limitation, see [YOURLS wiki](https://github.com/YOURLS/YOURLS/wiki/Username-Passwords) for more detail
