# Base image PHP 8.3 avec Apache
FROM php:8.3-apache

# Installer dépendances système
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip

# Installer Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Activer le rewrite Apache
RUN a2enmod rewrite

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier uniquement les fichiers Composer pour profiter du cache Docker
COPY composer.json composer.lock ./

# Installer les dépendances sans exécuter les scripts auto
RUN composer install  --optimize-autoloader --no-interaction --no-scripts

# Copier le reste du projet
COPY . .

# Fixer les permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Configurer Apache pour écouter sur le port fourni par Railway
CMD sh -c "echo \"Listen 0.0.0.0:${PORT}\" > /etc/apache2/ports.conf && apache2-foreground"
