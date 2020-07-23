#!/bin/bash

# Update Apache port
sed -i "s/PORT/$PORT/g" /etc/apache2/ports.conf
sed -i "s/PORT/$PORT/g" /etc/apache2/sites-enabled/000-default
sed -i "s/PORT/$PORT/g" /run_test.sh

# Set any variables we have in the env for php
printenv |grep 'PHP_'|sed 's/^PHP_//' > /etc/php5/conf.d/user.ini

# Start apache
/usr/sbin/apache2ctl -DFOREGROUND

