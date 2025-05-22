# Modified php7.1-apache image

This project is intended provide a simple way of running PHP 7.1 on HA Cloud

## Prerequisite

This is designed to run on HA Cloud. However, this can be run on any platform. 


### Configure PHP Variables

At boot and environment variables (PHP7_*) are written to /usr/local/etc/php/conf.d/user.ini

It's important to note the 'PHP7_', as defining just 'PHP_' will include some other stuff we don't want to grab

### Docker Compose
```
version: "3"
services:
  test:
    image: ha247/hacloud-generic-apache-php5.5
    ports:
      - 8082:80
    environment:
      - PORT=80
      - PHP7_disable_functions=exec
      - PHP7_display_errors=On
      - PHP7_error_reporting=On
      - PHP7_max_execution_time=60
      - PHP7_max_input_time=60
      - PHP7_max_input_vars=300
      - PHP7_max_post_size=100M
      - PHP7_memory_limit=1024M
      - PHP7_post_max_size=100M
      - PHP7_short_open_tag=On
      - PHP7_upload_max_filesize=100M
```

### HA Cloud

Defining the PORT allows us to run this container  with the host network

The below config will make the container run on 127.0.0.1:8001. Nginx can then proxy the connections.
```
    environment:
      - PORT=8001
```


## Authors

* [Nick Bascombe-Fox] (https://github.com/nick-fox)
