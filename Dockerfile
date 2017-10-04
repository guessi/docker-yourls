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

WORKDIR /opt/yourls

ADD conf/ /

ADD https://github.com/dgw/yourls-dont-track-admins/archive/master.tar.gz     \
    /opt/dont-track-admins.tar.gz
ADD https://github.com/timcrockford/302-instead/archive/master.tar.gz         \
    /opt/302-instead.tar.gz
ADD https://github.com/YOURLS/force-lowercase/archive/master.tar.gz           \
    /opt/force-lowercase.tar.gz
ADD https://github.com/guessi/yourls-mobile-detect/archive/master.tar.gz      \
    /opt/mobile-detect.tar.gz

RUN for i in dont-track-admins 302-instead force-lowercase mobile-detect; do  \
      mkdir -p user/plugins/${i}                                            ; \
      tar zxvf /opt/${i}.tar.gz --strip-components=1 -C user/plugins/${i}   ; \
    done

# security enhancement: remove sample configs
RUN rm -rf user/config-sample.php                                             \
           user/plugins/sample*                                            && \
    (find . -type d -name ".git" -exec rm -rf {} +)
