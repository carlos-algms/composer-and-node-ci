FROM php:7.1
MAINTAINER Carlos A. Gomes <carlos.algms@gmail.com>

# Add Node.js repo
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get install --no-install-recommends -y \  
  nodejs \
  build-essential \
  openssh-client \
  
 # Slim down image
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_* \
 # Show versions
 && php -v \
 && echo "node: `node -v` " \
 && echo "npm: `npm -v`" \
 # Install composer
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
 
