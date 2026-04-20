FROM php:8.2-apache


RUN apt-get update && apt-get install -y \

    mariadb-server mariadb-client libpng-dev libjpeg-dev \

    && docker-php-ext-install gd mysqli pdo_mysql \

    && apt-get clean


RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

ADD https://wordpress.org/latest.tar.gz /tmp/wordpress.tar.gz
RUN tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/wordpress.tar.gz \
    && chown -R www-data:www-data /var/www/html

COPY ./my-theme /var/www/html/wp-content/themes/my-custom-theme


COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh


EXPOSE 80 3306


ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
