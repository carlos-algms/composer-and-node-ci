FROM debian:8.9
MAINTAINER David Sferruzza <david.sferruzza@gmail.com>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
ENV COMPOSER_NO_INTERACTION 1

# Add Node.js repo
RUN \
 curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get install --no-install-recommends -y \
 curl \
 nodejs \
 build-essential \
 apt-transport-https \
 ca-certificates \
 gnupg2 \
 openssh-client \
 bzip2 \
 git \
 php5-cli \
 nodejs \
 # Slim down image
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_* \
 # Show versions
 && php -v && node -v && npm -v \
 # Install composer
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
 && composer selfupdate
 
