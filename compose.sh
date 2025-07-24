#!/bin/bash

# Use .env variables
set -a
source .env
set +a

# start compose with project name namespace
docker compose -p "${PROJECT_NAME}" up -d

# Parse HTTP_HOST and HTTP_PORT
HTTP_HOST_ONLY="$HTTP_HOST"
HTTP_PORT_ONLY="$HTTP_PORT"

if [[ "$HTTP_HOST" == *:* ]]; then
  HTTP_PORT_ONLY="${HTTP_HOST##*:}"
  HTTP_HOST_ONLY="${HTTP_HOST%%:*}"
fi

# Escape for PHP
PHP_HTTP_HOST_ESCAPED=$(printf '%s' "$HTTP_HOST_ONLY" | sed "s/'/\\\\'/g")
PHP_HTTP_PORT_ESCAPED=$(printf '%s' "$HTTP_PORT_ONLY" | sed "s/'/\\\\'/g")

# Check if WP_HOME is already defined
if grep -q "define('WP_HOME'" wp-config.php; then
  echo "WP_HOME already defined. Skipping injection."
else
  sed -i "/^\/\* That.*stop editing!.*\*\//i \
define('WP_HOME', 'http://$PHP_HTTP_HOST_ESCAPED:$PHP_HTTP_PORT_ESCAPED');\n\
define('WP_SITEURL', 'http://$PHP_HTTP_HOST_ESCAPED:$PHP_HTTP_PORT_ESCAPED');\n" wp-config.php
fi
