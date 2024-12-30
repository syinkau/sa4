#!/bin/bash

# Pastikan variabel lingkungan tersedia
if [[ -z "$HEROKU_API_TOKEN" || -z "$APP_NAME" ]]; then
  echo "HEROKU_API_TOKEN or APP_NAME is not set. Exiting."
  exit 1
fi

# Restart dynos menggunakan API Heroku
echo "Restarting Heroku dynos for app: $APP_NAME"
curl -X DELETE "https://api.heroku.com/apps/$APP_NAME/dynos" \
     -H "Content-Type: application/json" \
     -H "Accept: application/vnd.heroku+json; version=3" \
     -H "Authorization: Bearer $HEROKU_API_TOKEN"
