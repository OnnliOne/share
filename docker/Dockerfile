FROM alpine:latest

ARG VERSION

# Install the needed software
RUN apk add --no-cache curl nginx php8-fpm php8-sqlite3 php8-opcache sqlite nodejs git npm bash build-base supervisor

# Create the www-data user and group
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

# Link php bin
RUN ln -s /usr/bin/php8 /usr/bin/php

# Copy supervisor conf file
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Set default workdir
WORKDIR  /var/www/

COPY docker/docker-entrypoint.sh .

# Download Software
# ADD https://git.pomf.se/Pomf/share/archive/v${VERSION}.tar.gz v${VERSION}.tar.gz
# RUN tar xvf v${VERSION}.tar.gz

# Create the needed directories
RUN mkdir /var/www/share/dist && \
    mkdir /var/www/db && \
    mkdir /var/www/files

# Create the Sqlite DB
RUN sqlite3 /var/www/db/database.sq3 -init /var/www/share/sqlite_schema.sql && \
    chown -R www-data:www-data /var/www && \
    chmod -R 775 /var/www/

# Fix script paths
RUN chmod a+x /var/www/share/checkdb.sh && \
    chmod a+x /var/www/share/checkfiles.sh && \
    sed -i 's#/path/to/files/#/var/www/share/files/#g' /var/www/share/checkfiles.sh && \
    sed -i 's#/path/to/db/database.sq3#/var/www/db/database.sq3#g' /var/www/share/checkdb.sh

# Add scripts to cron
RUN echo "0,30 * * * * bash /var/www/share/checkfiles.sh" >> /var/spool/cron/crontabs/www-data && \
    echo "0,30 * * * * bash /var/www/share/checkdb.sh" >> /var/spool/cron/crontabs/www-data

# Copy Nginx Server conf
COPY docker/nginx.conf /etc/nginx/http.d/

# Copy SSL certs
COPY docker/ssl /etc/ssl

# Copy Uguu config
COPY dist.json /var/www/share/dist.json

# Give permissions to www-data
RUN chown -R www-data:www-data /run /var/lib/php8 /var/lib/nginx /var/log/nginx /var/log/php8 /etc/nginx /etc/php8

# Change user to www-data
USER www-data

# Expose port 80 from the container
EXPOSE 80

# Expose port 443 from the container
EXPOSE 443

# Load entrypoint
ENTRYPOINT [ "bash", "/var/www/docker-entrypoint.sh" ]