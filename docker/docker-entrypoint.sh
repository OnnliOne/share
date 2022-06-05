#!/bin/bash
cd /var/www/share/
make
make install
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
