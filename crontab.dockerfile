FROM daocloud.io/php:7.1.25-fpm-alpine

MAINTAINER 0758jian <85171648@qq.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
	&& apk add --no-cache --virtual .build-deps \
	$PHPIZE_DEPS \
	tzdata \
	&& ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
	&& sed -i 's/;date.timezone =/date.timezone = Asia\/Shanghai/g' /usr/local/etc/php/php.ini
WORKDIR /var/www