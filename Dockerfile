ARG FROM_IMAGE=php:8-cli
FROM $FROM_IMAGE

LABEL maintainer="Carlos A. Gomes <carlos.algms@gmail.com>"


RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        util-linux \
        zsh \
        vim \
        ca-certificates \
        zip \
        unzip \
        openssh-client \
        rsync \
        git \
        default-mysql-client \
        make \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/cache/debconf/*-old \
    && rm -rf /usr/share/doc/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/*


ARG PECL_EXT="mcrypt-1.0.4"
ARG PHP_EXT="mysqli pspell zip"
ARG ENABLE_EXT="mcrypt"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libzip4 \
        libmcrypt4 \
        aspell \
        g++ \
        autoconf \
        libzip-dev \
        libmcrypt-dev \
        libaspell-dev \
        libpspell-dev \
    && ( \
        [ -z "$PECL_EXT" ] || \
        ( \
            pecl install $PECL_EXT \
            && docker-php-ext-enable $ENABLE_EXT \
        ) \
    ) \
    && docker-php-ext-install -j "$(nproc)" $PHP_EXT \
    && apt-get remove -y \
        g++ \
        autoconf \
        libzip-dev \
        libmcrypt-dev \
        libaspell-dev \
        libpspell-dev \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /var/cache/debconf/*-old \
    && rm -rf /usr/share/doc/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/*


RUN curl "https://getcomposer.org/installer" --output "composer-setup.php" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm "composer-setup.php"


ARG DEPLOYER_VERSION="v6.8.0"
RUN curl -L https://deployer.org/releases/${DEPLOYER_VERSION}/deployer.phar --output /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep


# Install node, npm and yarn
ARG NODE_VERSION="v16.13.0"
RUN curl -O https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz \
    && tar xJf node-v*.xz -C /usr --strip-components=1 --no-same-owner \
    && rm node-v*.xz \
    && npm i -g yarn


COPY zshrc /root/.zshrc
