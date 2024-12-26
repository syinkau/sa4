#!/bin/bash

# Ganti <HEROKU_API_KEY> dengan API Key Heroku Anda
# Ganti <APP_NAME> dengan nama aplikasi Anda
HEROKU_API_KEY="HRKU-c24b5700-75f1-40a6-8b7d-5ffb7e53488a"
APP_NAME="nuhacipesk"

echo "Restarting dynos for app $APP_NAME..."

# Panggil API untuk merestart dynos
curl -n -X DELETE https://api.heroku.com/apps/$APP_NAME/dynos \
    -H "Authorization: Bearer $HEROKU_API_KEY" \
    -H "Accept: application/vnd.heroku+json; version=3"

echo "Dynos restarted successfully!"
