# Use the official PHP 8.0 image with Apache
FROM php:8.0-apache

# Install Xdebug and other dependencies
ENV XDEBUG_PORT 9000
ENV XDEBUG_IDEKEY docker

RUN pecl install "xdebug" \
    && docker-php-ext-enable xdebug

RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.client_port=${XDEBUG_PORT}" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.idekey=${XDEBUG_IDEKEY}" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.log=/tmp/xdebug.log" >> /usr/local/etc/php/conf.d/xdebug.ini

# Enable Apache mod_rewrite
RUN a2enmod rewrite



# Expose port 80 for the web server
EXPOSE 80