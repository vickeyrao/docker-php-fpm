FROM php:8.5.8-fpm-alpine

RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd exif opcache

RUN \
    adduser -S -H -h /var/cache/php-fpm -G users -u 1000 php-fpm \
    && apk add --no-cache ffmpeg imagemagick zip pciutils usbutils \ 
    && rm -rf /var/cache/apk/*
