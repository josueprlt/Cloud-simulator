# API/Dockerfile
FROM php:8.2-cli

#test pull request
# Définir la variable d'environnement
ENV COMPOSER_ALLOW_SUPERUSER=1

# Installer les extensions nécessaires et Composer
RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    unzip \
    zip \
    && docker-php-ext-install pdo pdo_pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copier Composer depuis une image officielle
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Définir le répertoire de travail et copier les fichiers de l'application
WORKDIR /app
COPY . .

# Installer les dépendances en utilisant Composer
RUN composer install --no-interaction --optimize-autoloader

# Exposer le port pour l'application
EXPOSE 8000

# Commande par défaut pour démarrer l'application
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
