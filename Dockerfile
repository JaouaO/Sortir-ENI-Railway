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

# Activer le module rewrite d'Apache
RUN a2enmod rewrite

# Adapter Apache au port fourni par Railway
RUN echo "Listen ${PORT}" > /etc/apache2/ports.conf \
    && echo "<VirtualHost *:${PORT}>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

# Définir le dossier de travail
WORKDIR /var/www/html

# Étape 1 : copier uniquement composer.json et composer.lock (pour le cache)
COPY composer.json composer.lock ./

# Étape 2 : installer les dépendances PHP sans exécuter les scripts (car bin/console n’est pas encore là)
RUN composer install --no-interaction --no-scripts --optimize-autoloader

# Étape 3 : copier le reste du projet
COPY . .

# Étape 4 : exécuter les scripts post-install (maintenant bin/console existe)
RUN composer run-script --no-interaction post-install-cmd || true

# Fixer les permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html
