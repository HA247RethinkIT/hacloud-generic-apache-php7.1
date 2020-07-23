#!/bin/bash

# Wait for haproxy to start
sleep 2

# Check we are alive
curl --silent --fail http://localhost:PORT/index.php || exit 1

