# Use the base PHP 8.4 FPM image
FROM php:8.4-fpm

# Install necessary dependencies for Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    git \
    libonig-dev \
    cron \
    supervisor \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql mbstring zip

# Install Redis extension via PECL
RUN apt-get install -y libssl-dev && \
    pecl install redis && \
    docker-php-ext-enable redis

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory
WORKDIR /app

# Create necessary directories for supervisor
RUN mkdir -p /var/log/supervisor /var/run/supervisor

# Copy configuration files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY php.ini /usr/local/etc/php/conf.d/99-custom.ini
COPY www.conf /usr/local/etc/php-fpm.d/www.conf
COPY scheduler /etc/cron.d/laravel-cron

# Set permissions for the cron file
RUN chmod 0644 /etc/cron.d/laravel-cron

# Apply cron job
RUN crontab /etc/cron.d/laravel-cron

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start Supervisord as the main process
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
