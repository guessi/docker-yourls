FROM php:7.1-apache

ENV YOURLS_VERSION 1.7.2
ENV YOURLS_PACKAGE https://github.com/YOURLS/YOURLS/archive/${YOURLS_VERSION}.tar.gz

RUN docker-php-ext-install pdo_mysql mysqli mbstring                       && \
    a2enmod rewrite ssl

RUN mkdir -p /opt/yourls                                                   && \
    curl -sSL ${YOURLS_PACKAGE} -o /tmp/yourls.tar.gz                      && \
    tar xf /tmp/yourls.tar.gz --strip-components=1 --directory=/opt/yourls

RUN sed -i -e '/ServerTokens/s/^.*$/ServerTokens Prod/g'                      \
           -e '/ServerSignature/s/^.*$/ServerSignature Off/g'                 \
        /etc/apache2/conf-available/security.conf

RUN echo "expose_php=Off" > /usr/local/etc/php/conf.d/php-hide-version.ini

RUN apt-get update                                                         && \
    apt-get install --no-install-recommends -y git-core                    && \
    apt-get clean

RUN git clone https://github.com/dgw/yourls-dont-track-admins.git             \
    /opt/yourls/user/plugins/dont-track-admins                             && \
    git clone https://github.com/timcrockford/302-instead.git                 \
    /opt/yourls/user/plugins/302-instead                                   && \
    git clone https://github.com/YOURLS/force-lowercase.git                   \
    /opt/yourls/user/plugins/force-lowercase                               && \
    git clone https://github.com/guessi/yourls-mobile-detect.git              \
    /opt/yourls/user/plugins/mobile-detect

ADD conf/ /

WORKDIR /opt/yourls
