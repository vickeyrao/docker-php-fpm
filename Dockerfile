FROM php:8.2.0-fpm-bullseye

RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd exif opcache 	&& \
    apt-get clean 	&& \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    rm -rf /var/lib/apt/lists/* 

RUN \
	adduser --system --disabled-password --home /var/cache/php-fpm --gid 100 --uid 1000 php-fpm \
	&& sed -i "s#user = www-data.*#user = php-fpm#g" /usr/local/etc/php-fpm.d/www.conf \
	&& sed -i "s#group = www-data.*#group = users#g" /usr/local/etc/php-fpm.d/www.conf \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends ffmpeg imagemagick zip pciutils usbutils\
	&& apt-get clean \
	&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
	&& rm -rf /var/lib/apt/lists/* 
