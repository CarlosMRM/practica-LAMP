#!/bin/bash
#Instalar LAMP

sudo apt purge oracle* -y
sudo apt autoclean
sudo apt autoremove -y
sudo apt update
sudo apt upgrade -y
sudo apt install ssh -y
#|----------------------->Instalación de Apache2 <-------------------------------|
sudo apt install apache2 -y
sudo systemctl restart apache2.service
#|------------------------>Instalación de GIT <----------------------------------|
sudo apt install git -y
sudo apt update 
sudo apt upgrade -y
#|------------------------>Instalación de MySQL <--------------------------------|
sudo apt install mysql-server -y
#sudo mysql_secure_installation
#echo "USE mysql;"
#echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'nueva_contraseña';"
#echo "FLUSH PRIVILEGES;"
#echo "exit"
sudo mysql -u root < ./scripts/cambiaPass.sql
#|------------------------>Instalación de PHP <----------------------------------|
sudo apt install php libapache2-mod-php php-mysql -y
sudo systemctl restart apache2
# sudo dpkg -l  muestra paquetes instalados
# goaccess /var/log/apache2/access.log -c
#|-------------------->Crea archivo para probar PHP <----------------------------|
sudo echo '<?php

phpinfo();

?>' | sudo tee /var/www/html/info.php
#|------------------------>Instalación de Composer <-----------------------------|
#cd ~
#sudo apt install composer -y
#sudo apt install php-xml php-curl php-zip php-mbstring -y
#composer create-project phpmyadmin/phpmyadmin
#cd phpmyadmin/
#composer update
#cd ..
#sudo mv phpmyadmin/ /var/www/html/
cd ./scripts
./instalaComposer.sh
#|------------------------>Instalación de Adminer<------------------------------|
./instalaAdminer.sh
cd ..
#|------------------------>Instalación de GoAccess <----------------------------|
echo "deb http://deb.goaccess.io/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/goaccess.list
wget -O - https://deb.goaccess.io/gnugpg.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install goaccess -y
#|----------------------->Agregar base de datos a MySQL<------------------------|
mysql -u root -p1234 < ./db/database.sql
#|----------------------->Copia paginas<----------------------------------------|
sudo cp -r ./src /var/www/html/
sudo cp -r ./paginaMia /var/www/html/
#|---------------------->Creación de carpeta para Goaccess<---------------------|
sudo mkdir /var/www/html/stats
#|---->Creat archivo de contraseñas para el usuario que va a acceder a stats <--|
echo "Clave para el archivo htpasswd con el usuario carlos"
sudo htpasswd -c ~/.htpasswd carlos
#|--->Modificar el archivo de configuración de Apache para que el directorio stats
#tenga acceso restringido con usuario y contraseña -----------------------------|
#sudo nano /etc/apache2/sites-enabled/000-default.conf
#Entre <VirtualHost *:80>y </VirtualHost>, introducir el siguiente texto
#<VirtualHost *:80>
#        #ServerName www.example.com
#        ServerAdmin webmaster@localhost
#        DocumentRoot /var/www/html
#
#        <Directory "/var/www/html/stats">
#          AuthType Basic
#          AuthName "Acceso restringido"
#          AuthBasicProvider file
#          AuthUserFile "/home/devops/.htpasswd"
#          Require valid-user
#        </Directory>
#
#        ErrorLog ${APACHE_LOG_DIR}/error.log
#        CustomLog ${APACHE_LOG_DIR}/access.log combined
#</VirtualHost>
#Con el siguiente comando se genera un fichero en tiempo real
# sudo goaccess /var/log/apache2/access.log -o /var/www/html/stats/index.html --log-format=COMBINED --real-time-html 
#Con el siguiente comando se genera estatico, pero da error de formato de hora
# sudo goaccess /var/log/apache2/access.log -o /var/www/html/stats/index.html
echo "La contraseña para Mysql del usuario root es 1234"
echo "La contraseña para Mysql del usuario lamp_carlos es 1234"
echo "El usuario para acceder a localhost/stats es carlos y la clave, la que se pedia crear en el script"
echo "Adminer se encuentra en localhost/adminer.php"
echo "Antes de hacer nada hay que modificar el fichero de apache con: sudo nano /etc/apache2/sites-enabled/000-default.conf"
echo "Para crear el archivo en tiempo real de Goaccess: sudo goaccess /var/log/apache2/access.log -o /var/www/html/stats/index.html --log-format=COMBINED --real-time-html"

