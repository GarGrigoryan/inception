FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    wget \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    curl

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wp_setup.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/wp_setup.sh

WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/wp_setup.sh"]