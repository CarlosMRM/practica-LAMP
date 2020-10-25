#!/bin/bash
cd ~/
wget "https://github.com/vrana/adminer/releases/download/v4.7.7/adminer-4.7.7.php"
sudo mv ./adminer-4.7.7.php /var/www/html/
sudo ln -s /var/www/html/adminer-4.7.7.php /var/www/html/adminer.php

