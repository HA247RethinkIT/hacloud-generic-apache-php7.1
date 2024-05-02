FROM ubuntu:14.04
MAINTAINER devops@ha247.co.uk

ENV PORT 80

# Ensure UTF-8
RUN locale-gen en_GB.UTF-8
ENV LANG       en_GB.UTF-8
ENV LC_ALL     en_GB.UTF-8


# Make sure apt is uptodate
RUN DEBIAN_FRONTEND=noninteractive
RUN set -x && apt-get update
RUN set -x && apt-get install -y --no-install-recommends \
  unzip \
  curl

# Install services
RUN set -x \
    && apt-get install -y --no-install-recommends \
        ssmtp \
        dnsmasq 

# Install apache and php
RUN set -x \
    && apt-get install -y --no-install-recommends \
        apache2 \
        apache2-mpm-prefork \
        apache2-utils \
        apache2.2-bin \
        apache2.2-common \
        libapache2-mod-php5 \
        libapache2-mod-rpaf \
        php5-cli \
        php5-common \
        php5-json \
        php5-intl \
        php5-curl \
        php5-mysql \
        php5-memcached \
        php5-mcrypt \
        php5-gd \
        php5-sqlite \
        php5-xmlrpc \
        php5-xsl \
        php5-geoip \
        php5-ldap \
        php5-memcache \
        php5-memcached \
        php5-imagick \
        php5-imap \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean -y


# Add test
COPY test/run_test.sh /
RUN chmod +x /run_test.sh

# Add index.php to webroot - for testing
COPY config/index.php /var/www/index.php

# Add custom config & start up script
COPY config/000-default /etc/apache2/sites-enabled/000-default
COPY config/ports.conf /etc/apache2/ports.conf
COPY config/security /etc/apache2/conf.d/security
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Ubuntu 14.04 comes with ssmtp intalled. We need to configure the mailhub to the the IP Address of the host.
# The Docker gateway is 172.17.0.1. Install Exim or Sendmail here
RUN sed -i 's/^mailhub=mail/mailhub=172.17.0.1/' /etc/ssmtp/ssmtp.conf

# Enable Apache modules
RUN a2enmod rewrite
RUN a2enmod headers

# Expose Apache
EXPOSE $PORT
 
# Launch Apache
CMD ["/entrypoint.sh"]
