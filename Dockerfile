
FROM debian:buster

ENV AUTOINDEX on

RUN apt-get update && apt-get upgrade -y && apt-get install nano && apt-get install -y wget && apt-get install unzip
RUN apt-get -y install php-fpm php-mysql php-mbstring php-xml
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt-get -y install openssl

COPY /srcs/default_on /etc/nginx/sites-available/default

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.zip && unzip *.zip && rm *.zip
RUN mv phpMyAdmin-5.1.0-all-languages /var/www/html/phpmyadmin
COPY /srcs/config.inc.php /var/www/html/phpmyadmin
RUN wget https://wordpress.org/latest.tar.gz && tar xzf latest.tar.gz && rm latest.tar.gz
RUN mv wordpress /var/www/html
COPY /srcs/wp-config.php /var/www/html/wordpress
RUN rm /var/www/html/index.nginx-debian.html
RUN chown -R www-data:www-data /var/www/html/*
COPY /srcs/init.sh ./
COPY /srcs/change_autoindex.sh ./
COPY /srcs/default_on ./
COPY /srcs/default_off ./
CMD bash init.sh

EXPOSE 80 443