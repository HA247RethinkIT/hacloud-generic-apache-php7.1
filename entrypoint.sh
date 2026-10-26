#!/bin/bash

# Update Apache port
sed -i "s/PORT/$PORT/g" /etc/apache2/ports.conf
sed -i "s/PORT/$PORT/g" /etc/apache2/sites-enabled/000-default.conf

# Set any variables we have in the env for php.
# Accept PHP_ or PHP7_ followed by a lowercase ini directive. The base image
# defines its own PHP_* build vars (PHP_VERSION, PHP_INI_DIR...) which are
# all uppercase, so they are skipped.
printenv | grep -E '^PHP7?_[a-z]' | sed -E 's/^PHP7?_//' > /usr/local/etc/php/conf.d/user.ini
# Hide PHP Version
echo 'expose_php = Off' >> /usr/local/etc/php/conf.d/user.ini

# Start apache
/usr/sbin/apache2ctl -DFOREGROUND

