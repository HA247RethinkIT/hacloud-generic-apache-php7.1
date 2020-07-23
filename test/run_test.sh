#!/bin/bash

# Wait for Apache to start
sleep 2

# Check we are alive
curl --silent --fail http://localhost:${PORT}/index.php || exit 1

