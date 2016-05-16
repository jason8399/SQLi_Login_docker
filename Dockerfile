FROM nginx

MAINTAINER JasonPan "jason8399@gmail.com"

RUN apt-get update && apt-get install wget -y
RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
RUN echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.ist
RUN wget https://www.dotdeb.org/dotdeb.gpg
RUN apt-key add dotdeb.gpg
RUN rm dotdeb.gpg

RUN apt-get update && \
	apt-get install php7.0-cli\
	php7.0-curl\
	php7.0-dev\
	php7.0-fpm\
	php7.0-gd\
	php7.0-mysql\
	php7.0-mcrypt\
	php7.0-opcache\
	git -y

RUN git clone https://github.com/ChiVincent/SQLi_Login.git
RUN mkdir -p /var/www/html/
WORKDIR SQLi_Login
RUN cp -r * /var/www/html/
WORKDIR /
RUN rm -rf SQLi_Login

COPY config/default.conf /etc/nginx/conf.d/
COPY config/www.conf /etc/php/7.0/fpm/pool.d/

CMD service php7.0-fpm start && nginx -g "daemon off;"
