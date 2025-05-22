FROM php:7.1.33-apache
LABEL maintainer="devops@ha247.co.uk"

ENV PORT=80 \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_GB.UTF-8 \
    LC_ALL=en_GB.UTF-8

# Generate locale
RUN apt-get update \
 && apt-get install -y --no-install-recommends locales \
 && locale-gen en_GB.UTF-8

# Basic utilities
RUN apt-get install -y --no-install-recommends \
      curl \
      unzip \
      msmtp-mta \
      dnsmasq

# Copy and set up test script
COPY test/run_test.sh /run_test.sh
RUN chmod +x /run_test.sh

# Copy a simple index.php for smoke-testing
COPY config/index.php /var/www/html/index.php

# Apache site & port configs
COPY config/000-default /etc/apache2/sites-enabled/000-default
COPY config/ports.conf  /etc/apache2/ports.conf

# Custom security config
COPY config/security /etc/apache2/conf-available/security.conf
RUN a2enconf security

# Entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Configure msmtp to use Docker gateway
COPY config/msmtprc /etc/msmtprc

# Enable Apache modules
RUN a2enmod rewrite headers

# Expose port and start
EXPOSE $PORT
CMD ["/entrypoint.sh"]
