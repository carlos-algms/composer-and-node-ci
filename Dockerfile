FROM ubuntu:jammy

LABEL maintainer="Carlos A. Gomes <carlos.algms@gmail.com>"

RUN \
  apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
    apt-transport-https \
    curl \
    default-mysql-client \
    dirmngr \
    git \
    gpg \
    gpg-agent \
    make \
    openssh-client \
    rsync \
    software-properties-common \
    tini \
    unzip \
    vim \
    xz-utils \
    zip \
    zsh \
  && apt-get autoremove -y --purge \
  && apt-get autoclean -y \
  && apt-get clean -y \
  && rm -rf /var/cache/debconf/*-old \
  && rm -rf /usr/share/doc/* \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/apt/*


ARG PHP_VERSION=8.2
RUN \
  LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    php-pear \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-sqlite3 \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
  && apt-get autoremove -y --purge \
  && apt-get autoclean -y \
  && apt-get clean -y \
  && rm -rf /var/cache/debconf/*-old \
  && rm -rf /usr/share/doc/* \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/apt/*


# https://getcomposer.org/download/
ARG COMPOSER_VERSION="2.4.1"
RUN \
  curl -L "https://getcomposer.org/installer" --output "composer-setup.php" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php \
    --install-dir=/usr/local/bin \
    --filename=composer \
    --version=${COMPOSER_VERSION} \
  && rm "composer-setup.php"


ARG DEPLOYER_VERSION="v6.8.0"
RUN \
  curl -L "https://deployer.org/releases/${DEPLOYER_VERSION}/deployer.phar" \
      --output /usr/local/bin/dep \
  && chmod +x /usr/local/bin/dep


# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
# ARG TARGETARCH

# # Install node, npm and yarn
# ARG NODE_VERSION="v16.17.1"
# RUN \
#   if [ "${TARGETARCH}" = "amd64" ]; then \
#     ARCHITECTURE=x64; \
#   elif [ "${TARGETARCH}" = "arm" ]; then \
#     ARCHITECTURE=armv7l; \
#   elif [ "${TARGETARCH}" = "arm64" ]; then \
#     ARCHITECTURE=arm64; \
#   else \
#     echo "Unknown TARGETARCH: '${TARGETARCH}'";\
#     exit 1; \
#   fi \
#   && curl -L "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-${ARCHITECTURE}.tar.xz" \
#     --output node.tar.xz \
#   && tar xJf node.tar.xz -C /usr --strip-components=1 --no-same-owner \
#   && rm node.tar.xz \
#   && npm i -g yarn

# https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
RUN \
  curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && npm i -g yarn \
  && apt-get autoremove -y --purge \
  && apt-get autoclean -y \
  && apt-get clean -y \
  && rm -rf /var/cache/debconf/*-old \
  && rm -rf /usr/share/doc/* \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/apt/*

COPY zshrc /root/.zshrc

ENTRYPOINT ["/usr/bin/tini", "--"]
