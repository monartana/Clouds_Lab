#!/bin/bash


if [ "$DB_TYPE" = "internal" ]; then

    echo "Запуск вбудованої СКБД"

    service mariadb start

    

    if [ ! -d "/var/lib/mysql/wordpress" ]; then

        echo "Ініціалізація нової бази даних"

        mysql -e "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost' IDENTIFIED BY 'wp_pass'; FLUSH PRIVILEGES;"

    fi

else

    echo "Використовується зовнішня СКБД: $EXTERNAL_DB_HOST"

fi


exec "$@"
