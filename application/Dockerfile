FROM ubuntu:22.04 as builder

RUN apt-get update && \
    apt-get install -y \
        apache2 \
        php \
        php-cli \
        php-mysql \
        mysql-server \
        composer \
        git && \

# Config Apache        
COPY laravel.conf /etc/apache2/sites-available/laravel.conf

RUN a2ensite laravel.conf && \
    a2ensite 000-default.conf && \
    a2enmod rewrite

WORKDIR /var/www/html

RUN rm /var/www/html/*

RUN git clone https://github.com/DNXLabs/ChallengeDevOps.git .

RUN a2enmod rewrite
#permissions and dependencies 
RUN chown -R www-data:www-data /var/www/html && \
    chown -R 775 /var/www/html/storage && \
    chown -R 775 /var/www/html/bootstrap/cache && \
    composer install --optimize-autoloader --no-dev && \
    php artisan key:generate && \
    php artisan config:cache && \
    cp .env.example .env && \
    sed -1 "s/DB_HOST=.* /DB_HOST=/" .env && \
    sed -1 "s/DB_DATABASE=.* /DB_DATABASE=homestead/" .env && \
    sed -1 "s/DB_USERNAME=.* /DB_USERNAME=root/" .env && \
    sed -1 "s/DB_PASSWORD=.* /DB_PASSWORD=secret/" .env

#expose port 80 for web trafic
EXPOSE 80
# initiate apache
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]