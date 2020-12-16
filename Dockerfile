FROM php:7.2.27-fpm-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update && apk add --no-cache --virtual .build-deps \
  imagemagick-dev \
  libjpeg-turbo-dev \
  freetype-dev \
  libzip-dev \
  libpng-dev \  
  curl-dev \
  libjpeg-turbo-dev && \
  docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr && \
  docker-php-ext-install -j "$(nproc)" gd \
  bcmath \
  exif \
  mysqli \
  opcache \
  pdo_mysql \
  zip \
  curl
COPY php-ext-sg-install.sh /usr/local/bin
RUN sh /usr/local/bin/php-ext-sg-install.sh