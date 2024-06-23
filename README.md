# Dockerize YOURLS - Your Own URL Shortener

[![Docker Stars](https://img.shields.io/docker/stars/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)
[![Docker Pulls](https://img.shields.io/docker/pulls/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)
[![Docker Automated](https://img.shields.io/docker/automated/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)

## Before start, things you need to know...

### Difference between Official Build and why this project exist?

Back in 2017, I was a user of YOURLS (_Great thanks to upstream maintainers_). I found it's hard to build YOURLS into container image so I publish my customized YOURLS image build and scripts on [May 7, 2017](https://github.com/guessi/docker-yourls/commit/de4781444ee64edb12abaa3af401b383208817e4). Around half year later, [upstream YOURLS maintainers](https://github.com/YOURLS/YOURLS/graphs/contributors) published an official repo called "[YOURLS/docker](https://github.com/YOURLS/docker)" to build container images for YOURLS project on [Nov 11, 2017](https://github.com/YOURLS/docker/commit/75e37b0cabe62ba4d4691c2d0eb883f4a811c727). So it became two different image repositories.

### Should I use it or maybe Official build is better?

Ideally, official build should receive better support and it is always encourage to try Official Build first. The main differences between two projects is the way image build and w/wo plugins pre-loaded.

As time goes by, please take this project as a quick start guide for YOURLS and please don't get me wrong, I'm not pushing you away (existed users), if you still like this project? it is always welcome to stay here :-)


## Integrated Items

* [Yourls](http://yourls.org) - 1.9.2

| Container image tag      | Mobile-Detect version  | PHP version | OS version | Remark                                      |
|:-------------------------|:-----------------------|:------------|:-----------|:--------------------------------------------|
| 1.9.2-7 (alias of 1.9.2) | 3.74.3                 | PHP 8.3     | Debian 12  | Multi-platform support, linux/{amd64,arm64} |
| 1.9.2-6                  | 3.74.3                 | PHP 8.3     | Debian 12  | no code change, regular build only          |
| 1.9.2-5                  | 3.74.3                 | PHP 8.3     | Debian 12  | no code change, regular build only          |
| 1.9.2-4                  | 3.74.3                 | PHP 8.3     | Debian 12  | no code change, regular build only          |
| 1.9.2-3                  | 3.74.3                 | PHP 8.3     | Debian 12  | deprecated                                  |
| 1.9.2-2                  | 2.8.45                 | PHP 8.0     | Debian 10  | deprecated                                  |
| 1.9.2-1                  | 2.8.41                 | PHP 8.0     | Debian 10  | deprecated                                  |

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

> [!IMPORTANT]
> You should always change the default username/password pairs for both MySQL and YOURLS.

To run YOURLS service with customized config

    $ vim env.mysql
    $ vim env.yourls
    $ docker compose up [--build] [-d]


## Dashboard

* Default Login Page: http://localhost/admin/
* Default Username: **see env.yourls**
* Default Password: **see env.yourls**


## Advanced

### Create database backup

Execute `backup.sh` to get regular backup


### Restore backup from backup file

Make sure there is no container running

    $ docker compose down
    $ docker ps

Cleanup "mysql-data" volume

    $ docker volume rm yourls_mysql-data

Make sure there is no sql file under "mysql-initdb" volume

    $ rm -vf ./volumes/docker-entrypoint-initdb.d/*

Move the backup sql file to "mysql-initdb" volume

    $ cp -vf ./mysql-dump-YYYYMMDD-hhmmss.sql ./volumes/docker-entrypoint-initdb.d/
    $ docker compose up -d


## FAQ

### Why there would have no homepage for YOURLS?

    Check the answer at the link below
    - https://github.com/orgs/YOURLS/discussions/3638#discussioncomment-7192119

### How can I use non-default password or variables?

    simply modify the variables inside `env.*` before your first run.

### Limitations for environment files

    1. The value of `YOURLS_DB_PASS` inside `env.yourls` **SHOULD BE** exactly the same as `MYSQL_PASSWORD` in `env.mysql`.
    2. The value of `YOURLS_DB_USER` inside `env.yourls` **SHOULD BE**  exactly the same as `MYSQL_USER` in `env.mysql.
    3. All variables inside `env.mysql` and `env.yourls` **SHOULD NOT** contain `'=' (equal sign)`, `' ' (space)`, `'#' (number sign)`.

### Why it will show `Could not auto-encrypt passwords.` when log into admin page?

    Check the FAQ for YOURLS for more details
    - https://yourls.org/docs/guide/essentials/credentials#faq

### Why it will show `Could not write file .htaccess in YOURLS root directory.`?

    It should only happen at 1st time deployment, you may safely ignore it.

### Any others?

    Here are some useful links for you
    - https://yourls.org/docs
    - https://yourls.org/docs/category/troubleshooting
    - https://github.com/orgs/YOURLS/discussions
