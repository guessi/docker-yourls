FROM php:8.0-apache-buster

RUN sed -i -e '/^ServerTokens/s/^.*$/ServerTokens Prod/g'                     \
           -e '/^ServerSignature/s/^.*$/ServerSignature Off/g'                \
        /etc/apache2/conf-available/security.conf

RUN echo "expose_php=Off" > /usr/local/etc/php/conf.d/php-hide-version.ini

RUN apt update && apt install -y --no-install-recommends libonig-dev

RUN docker-php-ext-install pdo_mysql mysqli mbstring                       && \
    a2enmod rewrite ssl

ENV YOURLS_VERSION 1.8.2
ENV YOURLS_PACKAGE https://github.com/YOURLS/YOURLS/archive/${YOURLS_VERSION}.tar.gz
ENV YOURLS_CHECKSUM 6d818622e3ba1d5785c2dbcc088be6890f5675fd4f24a2e3111eda4523bbd7ae

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
ADD https://github.com/guessi/yourls-mobile-detect/archive/master.tar.gz      \
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
