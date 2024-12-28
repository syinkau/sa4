#!/bin/bash

# Nama aplikasi Heroku
APP_NAME="miusnrdasa"

# Token API Heroku Anda
HEROKU_API_TOKEN="HRKU-2c052e97-67d1-492b-9cb4-f47b7e8a069e"

# Panggil Heroku API untuk restart dynos
curl -X DELETE \
     -H "Authorization: Bearer $HEROKU_API_TOKEN" \
     -H "Accept: application/vnd.heroku+json; version=3" \
     https://api.heroku.com/apps/$APP_NAME/dynos
