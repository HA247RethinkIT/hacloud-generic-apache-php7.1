#!/bin/bash

sed -i "s/80/$PORT/g" /etc/apache2/ports.conf
sed -i "s/80/$PORT/g" /etc/apache2/sites-enabled/000-default


/usr/sbin/apache2ctl -DFOREGROUND

