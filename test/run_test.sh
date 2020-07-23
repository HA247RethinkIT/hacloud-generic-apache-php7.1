#!/bin/bash

# Wait for haproxy to start
sleep 2

# Check we are alive
curl http://localhost:PORT/index.php

