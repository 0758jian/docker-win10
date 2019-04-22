FROM daocloud.io/php:7.1.25-fpm-alpine

MAINTAINER 0758jian <85171648@qq.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
        && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        tzdata \
        curl-dev \
        imagemagick-dev \
        libtool \
        libxml2-dev \
    && apk add --no-cache \
        curl \
        imagemagick \
        freetype \
        libpng \
        libjpeg-turbo \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
    && docker-php-ext-configure gd \
       --with-gd \
       --with-freetype-dir=/usr/include/ \
       --with-png-dir=/usr/include/ \
       --with-jpeg-dir=/usr/include/ \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && pecl install -o -f redis \
    && docker-php-ext-install \
        curl \
        iconv \
        mbstring \
        gd \
        pdo \
        pdo_mysql \
        xml \
        zip \
        bcmath \
        opcache \
        mysqli \
    && docker-php-ext-enable redis \
        && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
        && sed -i 's/;date.timezone =/date.timezone = Asia\/Shanghai/g' /usr/local/etc/php/php.ini
WORKDIR /var/www