ARG FROM_IMAGE=php:7
FROM $FROM_IMAGE
MAINTAINER Carlos A. Gomes <carlos.algms@gmail.com>

RUN apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y \
      gnupg2 \
      apt-transport-https \
      unzip \
      build-essential \
      openssh-client \
      rsync \
      git \
      default-mysql-client \
      aspell \
      gettext-base \
      libfreetype6-dev \
      libjpeg62-turbo-dev \
      libmagickwand-dev \
      libmcrypt-dev \
      libpng-dev \
      libpspell-dev \
      libxml2-dev \
      libzip-dev \
      ca-certificates \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install --no-install-recommends --no-install-suggests -y \
      nodejs \
      yarn \
  # Slim down image
  && apt-get clean \
  && rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/* \
      /usr/share/man/?? \
      /usr/share/man/??_* \
  # Install composer
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  # Install Deployer - https://deployer.org/docs/getting-started.html
  && curl -LO https://deployer.org/releases/v6.8.0/deployer.phar \
  && mv deployer.phar /usr/local/bin/dep \
  && chmod +x /usr/local/bin/dep \
  # Show versions
  && php -v \
  && echo "node: `node -v` " \
  && echo "npm: `npm -v`"

ARG PECL_EXT="mcrypt-1.0.4 imagick-3.5.1"
RUN pecl install $PECL_EXT

ARG PHP_EXT="gd mysqli pdo_mysql opcache pspell bcmath exif zip"
RUN docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr; \
	docker-php-ext-install -j "$(nproc)" $PHP_EXT

ARG ENABLE_EXT="mcrypt imagick"
RUN docker-php-ext-enable $ENABLE_EXT
