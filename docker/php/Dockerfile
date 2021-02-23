FROM php:7.4-fpm

LABEL version="0.1"
LABEL maintaner="Andrew Pisarevsky <renakdup@gmail.com>"
LABEL source_url="https://github.com/renakdup/wp-docker-boilerplate-env"

ARG UID
ARG GUID
ARG USER=www-data
RUN usermod -u $UID $USER && groupmod -g $GUID $USER

# Configuring OS#
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

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /app

USER $USER


