FROM daocloud.io/php:7.0.33-fpm-alpine

MAINTAINER 0758jian <85171648@qq.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        imagemagick-dev \
        libtool \
        libxml2-dev \ 
    && apk add --no-cache \
        curl \
        git \
        imagemagick \
        freetype \
        libpng \
        libjpeg-turbo \
        freetype-dev \
        libpng-dev \
        libmcrypt-dev \
        libjpeg-turbo-dev \  
    && docker-php-ext-configure gd \
       --with-gd \
       --with-freetype-dir=/usr/include/ \
       --with-png-dir=/usr/include/ \
       --with-jpeg-dir=/usr/include/ \    
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && pecl install xdebug-2.6.1 \
    && pecl install -o -f redis \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install \
        curl \
        iconv \
        mcrypt \
        mbstring \
        gd \
        pdo \
        pdo_mysql \     
        xml \
        zip \
        bcmath \
        opcache \
    && docker-php-ext-enable redis \
    && curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer \
    && apk del -f .build-deps \
    && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev \
    && composer config -g repo.packagist composer https://packagist.laravel-china.org

WORKDIR /var/www