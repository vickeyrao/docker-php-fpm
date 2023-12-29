FROM php:8.3.1-fpm-bullseye

RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd exif opcache

RUN \
	adduser --system --disabled-password --home /var/cache/php-fpm --gid 100 --uid 1000 php-fpm \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends ffmpeg imagemagick zip pciutils usbutils\
	&& apt-get clean \
	&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
	&& rm -rf /var/lib/apt/lists/* 
