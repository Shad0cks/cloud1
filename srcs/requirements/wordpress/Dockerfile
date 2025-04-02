FROM debian:buster

RUN apt-get update \
	&& apt-get install -y php7.3 php-mysqli php-fpm wget curl \
	&& rm -rf /var/lib/apt/lists/*
	
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /var/www/html/
COPY ./conf/wp-config.php /var/www/

RUN mkdir /run/php

COPY ./tools/create_wordpress.sh /usr/local/bin/
ENTRYPOINT ["create_wordpress.sh"]

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]
