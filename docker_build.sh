#!/bin/bash
set -e

# Build and push the image, tagged latest and with the most recent git tag
TAG=$(git describe --tags --abbrev=0)
docker buildx build --platform linux/amd64 \
  -t ha247/hacloud-generic-apache-php7.1:latest \
  -t ha247/hacloud-generic-apache-php7.1:$TAG \
  --push .
