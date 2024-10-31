# API/Dockerfile
FROM php:8.2-cli

# Installer les extensions et Composer
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

RUN composer install

EXPOSE 8000
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
