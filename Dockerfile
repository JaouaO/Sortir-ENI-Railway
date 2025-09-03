FROM php:8.3-apache

# Installer dépendances système + extensions PHP nécessaires à Symfony
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

# Activer mod_rewrite (utile pour Symfony routes)
RUN a2enmod rewrite

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier d’abord composer.json et composer.lock pour tirer parti du cache Docker
COPY composer.json composer.lock ./

# Installer dépendances Symfony en mode prod (pas de dev tools)
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Copier tout le projet
COPY . .

# Fixer les permissions (Apache = www-data)
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Exposer le port 80 (par défaut, Railway remplacera par $PORT)
EXPOSE 80

# Écrire le bon port dans Apache au runtime et démarrer Apache
CMD sh -c "echo \"Listen 0.0.0.0:${PORT}\" > /etc/apache2/ports.conf && apache2-foreground"
