FROM php:7.1
MAINTAINER Carlos A. Gomes <carlos.algms@gmail.com>

# Add Node.js repo
RUN \
 apt-get update \
 && apt-get install --no-install-recommends -y apt-transport-https \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && curl -sL https://deb.nodesource.com/setup_9.x | bash - \
 && apt-get install --no-install-recommends -y \  
  nodejs \
  unzip \
  build-essential \
  openssh-client \
  rsync \
  git \
  yarn \
  
  
 # Slim down image
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_* \
 # Show versions
 && php -v \
 && echo "node: `node -v` " \
 && echo "npm: `npm -v`" \
 # Install composer
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
 
