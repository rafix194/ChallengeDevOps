git clone https://github.com/DNXLabs/ChallengeDevOps.git
cd ChallengeDevOps
cp .env.example .env
sudo add-apt-repository ppa:ondrej/php
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y php7.4
sudo apt-get install php-mbstring php7.4-mbstring -y
sudo apt install php7.4-xml
sudo apt install php7.4-mysql
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer dump-autoload
composer install
php artisan key:generate
php artisan jwt:generate
php artisan migrate
php artisan db:seed
php artisan migrate:refresh
php artisan serve --host=0.0.0.0