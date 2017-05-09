# Dockerize YOURLS - Your Own URL Shortener

[![Docker Stars](https://img.shields.io/docker/stars/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)
[![Docker Pulls](https://img.shields.io/docker/pulls/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)
[![Docker Automated](https://img.shields.io/docker/automated/guessi/docker-yourls.svg)](https://hub.docker.com/r/guessi/docker-yourls/)


## Integrated Items

* [Yourls](http://yourls.org) - 1.7.2


## Integrated Plugins

* [302-instead](https://github.com/timcrockford/302-instead.git)
* [dont-track-admins](https://github.com/dgw/yourls-dont-track-admins.git)
* [fallback_url_config](http://diegopeinador.com/fallback-url-yourls-plugin)
* [force-lowercase](https://github.com/YOURLS/force-lowercase.git)
* [mobile-detect](https://github.com/guessi/yourls-mobile-detect.git)


## Usage

To run YOURLS service with default config

    $ docker-compose up --build

To run YOURLS service with customized config

    $ vim docker-compose.yaml
    $ docker-compose up --build


## Dashboard

* Default Login Page: http://127.0.0.1/admin/index.php
* Default Username: admin
* Default Password: my@dminP@ss


## FAQ

### How can I use non-default password or variables?

    simply modify the variable configures in `docker-compose.yaml` before run


## Known Issue

WebUI may show `Could not write file .htaccess in YOURLS root directory.`
at first time deployment, it is actually a false alarm, please ignore it.

WebUI may show `Could not auto-encrypt passwords.` when log into admin page,
it is Docker specific limitation, see [YOURLS wiki](https://github.com/YOURLS/YOURLS/wiki/Username-Passwords) for more detail
