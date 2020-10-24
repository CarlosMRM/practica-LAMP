ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234';
GRANT ALL PRIVILEGES ON lamp_db.users TO 'lamp_user'@'localhost';
FLUSH PRIVILEGES;
exit