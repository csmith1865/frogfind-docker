# Use PHP with Apache
FROM php:8.2-apache

# Install dependencies for Composer
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy source code
COPY . /var/www/html/

# Set working directory
WORKDIR /var/www/html/

# Run Composer install
RUN composer install --no-dev --optimize-autoloader

# Enable rewrite module if needed
RUN a2enmod rewrite

# Expose port
EXPOSE 80
