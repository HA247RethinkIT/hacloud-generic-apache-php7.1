# Generic Apache + Mod_PHP 5.5

This project is intended provide a simple way of running PHP 5.5 on HA Cloud

## Prerequisite

This is designed to run on HA Cloud. However, this can be run on any platform. 


### Configure PHP Variables

At boot and environment variables (PHP_*) are written to /etc/php5/conf.d/user.ini

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
      - PHP_disable_functions=exec()
      - PHP_display_errors=On
      - PHP_error_reporting=On
      - PHP_max_execution_time=60
      - PHP_max_input_time=60
      - PHP_max_input_vars=300
      - PHP_max_post_size=100M
      - PHP_memory_limit=1024M
      - PHP_post_max_size=100M
      - PHP_short_open_tag=On
      - PHP_upload_max_filesize=100M
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
