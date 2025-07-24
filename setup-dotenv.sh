#!/bin/bash

if ! grep -q "require_once(__DIR__ . '/vendor/autoload.php');" wp-config.php; then
  tmpfile=$(mktemp)
  head -n 2 wp-config.php > "$tmpfile"
  cat << 'EOF' >> "$tmpfile"
require_once(__DIR__ . '/vendor/autoload.php');
(new \Dotenv\Dotenv(__DIR__))->load();
EOF
  tail -n +3 wp-config.php >> "$tmpfile"
  mv "$tmpfile" wp-config.php
fi
docker exec "${PROJECT_NAME}_wordpress" composer require vlucas/phpdotenv
sed -i "s/define( 'DB_NAME', '[^']*' );/define( 'DB_NAME', getenv('PROJECT_NAME') );/" wp-config.php
sed -i "s/define( 'DB_USER', '[^']*' );/define( 'DB_USER', getenv('MYSQL_USER') );/" wp-config.php
sed -i "s/define( 'DB_PASSWORD', '[^']*' );/define( 'DB_PASSWORD', getenv('MYSQL_PASS') );/" wp-config.php
sed -i "s/define( 'DB_HOST', '[^']*' );/define( 'DB_HOST', getenv('PROJECT_NAME') . '_db' );/" wp-config.php
