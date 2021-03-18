
#!/bin/bash

bash change_autoindex.sh

service php7.3-fpm start
service mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql
echo "USE wordpress;" | mysql
echo "GRANT ALL ON wordpress TO 'root'@'localhost' WITH GRANT OPTION;" | mysql
echo "FLUSH PRIVILEGES;" | mysql
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql
service openssl start
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=IT/ST=75/L=Rome/O=42/CN=larmelli' -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
service nginx start

bash