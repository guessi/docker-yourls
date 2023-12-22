# PHP versions support:
# +--------+ -----------------+----------------------+------------------------+
# | Branch | Initial Releasae | Active Support Until | Security Support Until |
# +--------+ -----------------+----------------------+------------------------+
# | 8.1    | Nov 25, 2021     | Nov 25, 2023         | Nov 25, 2024           |
# | 8.2    | Dec  8, 2022     | Dec  8, 2024         | Dec  8, 2025           |
# | 8.3    | Nov 23, 2023     | Nov 23, 2025         | Nov 23, 2026           |
# +--------+ -----------------+----------------------+------------------------+
# - https://www.php.net/supported-versions.php
# - https://php.watch/versions
#
# Container image source:
# - https://hub.docker.com/_/php/tags?page=1&name=8.3-apache-bookworm

FROM php:8.3-apache-bookworm as yourls

RUN sed -i -e '/^ServerTokens/s/^.*$/ServerTokens Prod/g'                     \
           -e '/^ServerSignature/s/^.*$/ServerSignature Off/g'                \
        /etc/apache2/conf-available/security.conf

RUN echo "expose_php=Off" > /usr/local/etc/php/conf.d/php-hide-version.ini

RUN apt update                                                             && \
    apt install -y --no-install-recommends libonig-dev                     && \
    apt install -y tzdata

RUN docker-php-ext-install pdo_mysql mysqli mbstring                       && \
    a2enmod rewrite ssl

ENV YOURLS_VERSION 1.9.2
ENV YOURLS_PACKAGE https://github.com/YOURLS/YOURLS/archive/${YOURLS_VERSION}.tar.gz
ENV YOURLS_CHECKSUM 62a95ba766d62f3305d75944cbfe12d5a90c08c88fbf2f6e67150d36412b916f

RUN mkdir -p /opt/yourls                                                   && \
    curl -sSL ${YOURLS_PACKAGE} -o /tmp/yourls.tar.gz                      && \
    echo "${YOURLS_CHECKSUM} /tmp/yourls.tar.gz" | sha256sum -c -          && \
    tar xf /tmp/yourls.tar.gz --strip-components=1 --directory=/opt/yourls && \
    rm -rf /tmp/yourls.tar.gz

WORKDIR /opt/yourls

ADD https://github.com/YOURLS/timezones/archive/master.tar.gz                 \
    /opt/timezones.tar.gz
ADD https://github.com/dgw/yourls-dont-track-admins/archive/master.tar.gz     \
    /opt/dont-track-admins.tar.gz
ADD https://github.com/timcrockford/302-instead/archive/master.tar.gz         \
    /opt/302-instead.tar.gz
ADD https://github.com/YOURLS/force-lowercase/archive/master.tar.gz           \
    /opt/force-lowercase.tar.gz
ADD https://github.com/guessi/yourls-mobile-detect/archive/refs/tags/3.0.0.tar.gz \
    /opt/mobile-detect.tar.gz
ADD https://github.com/YOURLS/dont-log-bots/archive/master.tar.gz             \
    /opt/dont-log-bots.tar.gz
ADD https://github.com/luixxiul/dont-log-crawlers/archive/master.tar.gz       \
    /opt/dont-log-crawlers.tar.gz
ADD https://github.com/guessi/yourls-dont-log-health-checker/archive/master.tar.gz \
    /opt/dont-log-health-checker.tar.gz

RUN for i in $(ls /opt/*.tar.gz); do                                          \
      plugin_name="$(basename ${i} '.tar.gz')"                              ; \
      mkdir -p user/plugins/${plugin_name}                                  ; \
      tar zxvf /opt/${plugin_name}.tar.gz                                     \
        --strip-components=1                                                  \
        -C user/plugins/${plugin_name}                                      ; \
    done

ADD conf/ /

# security enhancement: remove sample configs
RUN rm -rf user/config-sample.php                                             \
           user/plugins/sample*                                            && \
    (find . -type d -name ".git" -exec rm -rf {} +)

# patch for dont-log-crawlers
# - https://github.com/guessi/docker-yourls/issues/6
# - https://github.com/luixxiul/dont-log-crawlers/issues/13
# - https://github.com/luixxiul/dont-log-crawlers/blob/master/plugin.php#L283-L297
RUN sed -i -e '/Blacklisted CIDRs from the DB/s/null/array()/' user/plugins/dont-log-crawlers/plugin.php

FROM yourls as noadmin

# security enhancement: leave only production required items
# ** note that it will still available somewhere in docker image layers
RUN rm -rf .git pages admin js css images sample* *.md                        \
           user/languages                                                     \
           user/plugins/random-bg                                             \
           yourls-api.php                                                     \
           yourls-infos.php                                                && \
    sed -i '/base64/d' yourls-loader.php                                   && \
    (find . -type f -name "*.html" ! -name "index.html" -delete)           && \
    (find . -type f -name "*.json" -o -name "*.md" -o -name "*.css" | xargs rm -f) && \
    (find . -type f -exec file {} + | awk -F: '{if ($2 ~/image/) print $1}' | xargs rm -f)

FROM yourls as theme

# please be awared that "Flynntes/Sleeky" here have no update for years
# you should take your own risk if you choose to have theme included
# - https://github.com/Flynntes/Sleeky/releases
# - https://github.com/Flynntes/Sleeky/issues

WORKDIR /opt/yourls

# sample configuration to integrate theme Sleeky-v2.5.0
# - ref: https://github.com/Flynntes/Sleeky#quick-start
ADD https://github.com/Flynntes/Sleeky/archive/refs/tags/v2.5.0.tar.gz        \
      /opt/theme-sleeky.tar.gz

RUN mkdir -p /tmp/sleeky-extracted                                         && \
    tar zxvf /opt/theme-sleeky.tar.gz                                         \
        --strip-components=1                                                  \
        -C /tmp/sleeky-extracted                                           && \
    mv -vf /tmp/sleeky-extracted/sleeky-backend user/plugins/theme-sleeky  && \
    mv -vf /tmp/sleeky-extracted/sleeky-frontend .                         && \
    rm -rvf /tmp/sleeky-extracted

# NOTE: you will need to activate the theme manually

# Uncomment the line below to include your own "config.php" setup
# ADD path-to-your-config/config.php /opt/yourls/user/config.php
#
# ref: https://github.com/YOURLS/YOURLS/blob/1.9.2/user/config-sample.php