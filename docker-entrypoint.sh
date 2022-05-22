#!/bin/bash

set -e

function get_time() {
   echo "$(date '+%D %T')"
}

function runcmd() {
  echo "$(get_time). Running command: $1"
  $1
}

ENVIRONMENT=${ENVIRONMENT:-production}
STORAGE_FOLDER=${STORAGE_FOLDER:-${BASE_PATH:-/var/www/html/laravelapp}/storage}

echo "Running Hydra-API Backend (${ENVIRONMENT})... "

echo "Creating storage subfolder."
for FOLDER in "app/public" \
            "framework/cache" \
            "framework/cache/data" \
            "framework/testing" \
            "framework/sessions" \
            "framework/views" \
            "logs" \
            "api-docs" \
            "keys"
do
  runcmd "mkdir -p ${STORAGE_FOLDER}/${FOLDER}"
done

runcmd "php artisan cache:clear"
runcmd "php artisan config:clear"
runcmd "php artisan route:clear"
runcmd "php artisan view:clear"

if [ "${ENVIRONMENT}" == "DEVELOPMENT" ]; then
  runcmd "php artisan package:discover --ansi"
else
    runcmd "php artisan package:discover --ansi"
    runcmd "php artisan config:cache"
    runcmd "php artisan route:cache"
    runcmd "php artisan view:cache"
fi


runcmd "php artisan migrate --seed --force"

runcmd "php artisan storage:link"

set +e
runcmd "chown -R www-data:www-data ${STORAGE_FOLDER}"
set -e

echo "Running php-fpm"
runcmd "exec php-fpm"