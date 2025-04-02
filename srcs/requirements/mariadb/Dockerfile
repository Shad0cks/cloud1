FROM debian:buster

EXPOSE 3306

COPY tools/setupbdd.sh ./


RUN apt-get update \
	&& apt-get -y install mariadb-server \
	&& apt-get -y install procps\
	&& rm -rf /var/lib/apt/lists/* 

COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

CMD ["bash","setupbdd.sh"]
