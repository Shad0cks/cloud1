FROM debian:buster

RUN apt-get update \
	&& apt-get install -y nginx openssl \
	&& rm -rf /var/lib/apt/lists/*
	
EXPOSE 443

RUN     openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/CN=siteadmin.duckdns.org"

COPY	./conf/nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]
