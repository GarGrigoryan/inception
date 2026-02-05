FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr"

COPY conf/nginx.conf /etc/nginx/sites-available/default

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]