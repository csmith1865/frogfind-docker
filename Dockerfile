# Use official PHP Apache image
FROM php:8.2-apache

# Copy source code into container
COPY . /var/www/html/

# Enable Apache mod_rewrite (if needed)
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html/

# Expose port (optional)
EXPOSE 80

# Default command (from the base image)
CMD ["apache2-foreground"]
