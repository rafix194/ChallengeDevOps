FROM base:v1 as builder
        
COPY laravel.conf /etc/apache2/sites-available/laravel.conf

RUN a2ensite laravel.conf && \
    a2ensite 000-default.conf && \
    a2enmod rewrite

RUN docker-php-ext-install pdo pdo_pgsql

WORKDIR /var/www/html

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
    sed -i "s/DB_HOST=.*/DB_HOST=mysql.ckrolti37rrx.ap-southeast-2.rds.amazonaws.com/" .env && \
    sed -i "s/DB_DATABASE=.*/DB_DATABASE=homestead/" .env && \
    sed -i "s/DB_USERNAME=.*/DB_USERNAME=homestead/" .env && \
    sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=secret01/" .env

ADD ./docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh
ENTRYPOINT ["/bin/docker-entrypoint.sh"]

#expose port 80 for web trafic
EXPOSE 80