FROM debian:buster

RUN apt-get update && apt-get install -y \
    nginx \
    mariadb-server \
    php-fpm \
    php-mysql \
    wget \
    unzip

RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    mv wordpress /var/www/html/ && \
    chown -R www-data:www-data /var/www/html/wordpress

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.zip && \
    unzip phpMyAdmin-5.1.1-all-languages.zip && \
    mv phpMyAdmin-5.1.1-all-languages /var/www/html/phpmyadmin

COPY srcs/nginx.conf /etc/nginx/sites-available/default
COPY srcs/wp-config.php /var/www/html/wordpress/
COPY srcs/config.inc.php /var/www/html/phpmyadmin/
COPY srcs/init.sql /tmp/
COPY srcs/server.crt /etc/ssl/certs/
COPY srcs/server.key /etc/ssl/private/

RUN service mysql start && \
    mysql < /tmp/init.sql

EXPOSE 80 443

CMD service nginx start && service mysql start && service php7.3-fpm start && tail -f /dev/null
