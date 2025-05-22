#!/bin/bash

# Update Apache port
sed -i "s/PORT/$PORT/g" /etc/apache2/ports.conf
sed -i "s/PORT/$PORT/g" /etc/apache2/sites-enabled/000-default.conf

# Set any variables we have in the env for php
printenv |grep 'PHP7_'|sed 's/^PHP7_//' > /usr/local/etc/php/conf.d/user.ini
# Hide PHP Version
echo 'expose_php = Off' >> /usr/local/etc/php/conf.d/user.ini

# Start apache
/usr/sbin/apache2ctl -DFOREGROUND

