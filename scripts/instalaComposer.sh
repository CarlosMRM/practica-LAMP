#!/bin/bash
cd ~
sudo apt install composer -y
sudo apt install php-xml php-curl php-zip php-mbstring -y
composer create-project phpmyadmin/phpmyadmin
cd phpmyadmin/
composer update
cd ..
sudo mv phpmyadmin/ /var/www/html/