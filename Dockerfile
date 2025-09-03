# Utiliser PHP 8.3 avec Apache
FROM php:8.3-apache

# Installer les dépendances système nécessaires et extensions PHP
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip \
    && a2enmod rewrite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Installer Composer depuis l'image officielle
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier uniquement les fichiers Composer pour optimiser le cache Docker
COPY composer.json composer.lock ./

# Installer les dépendances PHP en production (sans dev)
RUN composer install --optimize-autoloader --no-interaction

# Copier le reste du projet
COPY . .

# Fixer les permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Démarrage par défaut d'Apache
CMD ["apache2-foreground"]
