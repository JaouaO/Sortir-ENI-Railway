FROM php:8.3-apache

# Installer les dépendances système
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

# Activer rewrite Apache
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copier composer.* avant (meilleur cache Docker)
COPY composer.json composer.lock ./

# Installer les dépendances PHP directement dans l’image
RUN composer install --no-interaction --no-dev --optimize-autoloader

# Puis copier le reste du projet
COPY . .

# Compiler les assets (si tu utilises AssetMapper)
RUN php bin/console asset-map:compile || true

# Fixer les permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 8000
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
