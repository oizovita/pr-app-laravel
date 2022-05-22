#!/bin/bash

set -e

if [ "$MODE" == "backend" ]; then

  SCRIPT_NAME=public/index.php SCRIPT_FILENAME=public/index.php REQUEST_METHOD=GET cgi-fcgi -bind -connect 127.0.0.1:9000 | grep 'X-Powered-By: PHP'

elif [ "$MODE" == "nginx" ]; then

  /usr/sbin/service nginx status | grep 'is running'

fi
