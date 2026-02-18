FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/sites-available/default
COPY ./tools/index.html /var/www/static/index.html

CMD ["nginx", "-g", "daemon off;"]
