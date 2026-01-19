# 1) Base image with Apache + PHP
FROM php:8.2-apache

# 2) Install system deps for composer & PHP extensions (if you need any later)
RUN apt-get update && apt-get install -y \
    git \
    unzip \
 && rm -rf /var/lib/apt/lists/*

# 3) Install Composer binary
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4) Copy app code
COPY . /var/www/html/

# 5) Make sure working dir is where index.php lives
WORKDIR /var/www/html

# 6) Run composer install to generate vendor/
RUN composer install --no-dev --optimize-autoloader

# 7) Enable rewrite module (optional, depending on the app)
RUN a2enmod rewrite

# 8) Expose web port
EXPOSE 80

# 9) Default command from base image runs Apache
CMD ["apache2-foreground"]
