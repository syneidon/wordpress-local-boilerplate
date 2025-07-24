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

# Determine target file
if [ -f wp-config.php ]; then
  CONFIG_FILE="wp-config.php"
else
  CONFIG_FILE="wp-config-sample.php"
fi

# Check if WP_HOME is already defined
if grep -q "define('WP_HOME'" "$CONFIG_FILE"; then
  echo "WP_HOME already defined in $CONFIG_FILE. Skipping injection."
else
  echo "Injecting WP_HOME and WP_SITEURL into $CONFIG_FILE..."

  sed -i "/^\/\* That.*stop editing!.*\*\//i \
define('WP_HOME', 'http://$PHP_HTTP_HOST_ESCAPED:$PHP_HTTP_PORT_ESCAPED');\n\
define('WP_SITEURL', 'http://$PHP_HTTP_HOST_ESCAPED:$PHP_HTTP_PORT_ESCAPED');\n" "$CONFIG_FILE"
fi
