# Dockerize YOURLS - Your Own URL Shortener

[![Docker Stars](https://img.shields.io/docker/stars/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)
[![Docker Pulls](https://img.shields.io/docker/pulls/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)
[![Docker Automated](https://img.shields.io/docker/automated/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)


## Integrated Items

* [Yourls](http://yourls.org) - 1.9.1


## Integrated Plugins

* [timezones](https://github.com/YOURLS/timezones)
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
    $ docker-compose up [--build] [-d]


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

Cleanup "mysql-data" volume

    $ docker volume rm yourls_mysql-data

Make sure there is no sql file under "mysql-initdb" volume

    $ rm -vf ./volumes/docker-entrypoint-initdb.d/*

Move the backup sql file to "mysql-initdb" volume

    $ cp -vf ./mysql-dump-YYYYMMDD-hhmmss.sql ./volumes/docker-entrypoint-initdb.d/
    $ docker-compose up -d


## FAQ

### How can I use non-default password or variables?

    simply modify the variables inside `env.*` before your first run.

### Limitations for environment files

    * The value of `YOURLS_DB_PASS` inside `env.yourls` **SHOULD BE** exactly the same as `MYSQL_PASSWORD` in `env.mysql`.
    * The value of `YOURLS_DB_USER` inside `env.yourls` **SHOULD BE**  exactly the same as `MYSQL_USER` in `env.mysql.
    * All variables inside `env.mysql` and `env.yourls` **SHOULD NOT** contain `'=' (equal sign)`, `' ' (space)`, `'#' (number sign)`.

## Known Issue

WebUI may show `Could not write file .htaccess in YOURLS root directory.`
at first time deployment, it is actually a **false alarm**, please ignore it.

WebUI may show `Could not auto-encrypt passwords.` when log into admin page,
it is Docker specific limitation, see [YOURLS wiki](https://github.com/YOURLS/YOURLS/wiki/Username-Passwords) for more detail
