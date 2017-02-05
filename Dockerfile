FROM php:7.1.0-cli

MAINTAINER Patrick Paechnatz <patrick.paechnatz@gmail.com>
LABEL com.container.vendor="dunkelfrosch inc." \
      com.container.service="php/7.1/build" \
      com.container.priority="1" \
      com.container.project="php" \
      img.version="1.0.0" \
      img.description="our main php 7.1.n build essential system"

ENV TERM xterm \
    LC_ALL C \
    DEBIAN_FRONTEND noninteractive \
    TIMEZONE "Europe/Berlin"

# override default image user [jenkins]
USER root

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install redis-3.1.0 \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable redis xdebug
