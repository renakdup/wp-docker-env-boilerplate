ARG PHP_VER

FROM php:${PHP_VER}-fpm

LABEL version="0.1"
LABEL maintaner="Andrei Pisarevskii <renakdup@gmail.com>"
LABEL source_url="https://github.com/renakdup/wp-docker-boilerplate-env"

ARG UID
ARG GUID
ARG USER=www-data
RUN usermod -u $UID $USER && groupmod -g $GUID $USER

# Configuring OS
RUN echo 'alias ll="ls -l --color"' >>  /etc/bash.bashrc
RUN chown -R $USER:$USER /var/www

RUN apt-get update

# OS Utilities
RUN apt-get -y install \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    tree \
    vim \
    #nano \
    unzip \
    zip \
    wget \
    curl \
    curl \
    git

# PHP Extensions
RUN docker-php-ext-install \
    gd \
    mysqli \
    pdo \
    #pdo_pgsql \
    #pgsql \
    pdo_mysql \
    mbstring \
    tokenizer \
    opcache \
    exif \
    zip
    
# fix memory limit for php-cli
RUN echo 'memory_limit = -1' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini

# Install Composer
RUN wget https://getcomposer.org/download/2.0.1/composer.phar && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/

USER $USER


