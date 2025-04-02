#!/bin/sh

if [ -f ./wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
else
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm -rf latest.tar.gz

	rm -rf /etc/php/7.3/fpm/pool.d/www.conf
	mv ./www.conf /etc/php/7.3/fpm/pool.d/

	mv /var/www/wp-config.php /var/www/html/wordpress;
	sed -i "s/WORDPRESS_USER/$WORDPRESS_USER/" /var/www/html/wordpress/wp-config.php
	sed -i "s/PASSWD/$WORDPRESS_USER_PASSWORD/" /var/www/html/wordpress/wp-config.php
	sed -i "s/DATABASE_NAME/$DATABASE_NAME/" /var/www/html/wordpress/wp-config.php
	sed -i "s/DATABASE_HOST_NAME/$DATABASE_HOST_NAME/" /var/www/html/wordpress/wp-config.php
	
	wp core install --path=/var/www/html/wordpress/ --url=https://localhost --title=Inception --admin_user=$WORDPRESS_USER --admin_password=$WORDPRESS_USER_PASSWORD --admin_email=$WORDPRESS_USER_EMAIL --skip-email  --allow-root
	wp user create $OTHER_USER_LOGIN $OTHER_USER_EMAIL --role=subscriber --user_pass=$OTHER_USER_PASSWORD --allow-root --path=wordpress

fi


exec "$@"
