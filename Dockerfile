FROM php:8.1.0-fpm

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update && \
    apt-get install -y \
      autoconf \
      build-essential \
      nodejs && \
    pecl install \
      pcov \
      redis && \
    mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini && \
    echo "upload_max_filesize=5M" >> $PHP_INI_DIR/php.ini && \
    echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini && \
    apt-get install -y \
      apache2-utils \
      cron \
      git \
      zip \
      curl \
      sudo \
      unzip \
      libpq-dev \
      libonig-dev \
      libicu-dev \
      libfcgi-bin \
      libbz2-dev \
      libpng-dev \
      libjpeg-dev \
      libmcrypt-dev \
      libreadline-dev \
      libfreetype6-dev \
      nginx \
      postgresql-client \
      g++ && \
    docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ && \
    docker-php-ext-install \
      bz2 \
      pdo \
      intl \
      pgsql \
      iconv \
      bcmath \
      opcache \
      calendar \
      mbstring \
      pdo_pgsql \
      gd \
      pcntl \
      exif && \
    docker-php-ext-enable pcov && \
    curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --version=2.3.5 --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /usr/local/bin/composer && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    apt-get clean

ENV BASE_PATH=/var/www/html/laravelapp
WORKDIR ${BASE_PATH}

COPY ./ ./

#RUN npm install
#
#RUN composer install --optimize-autoloader

RUN rm -rf docker-entrypoint.sh && \
#    npm run production && \
    chmod 777 ${BASE_PATH}/bootstrap

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["backend"]

