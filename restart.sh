#!/bin/bash

# Nama aplikasi Heroku
APP_NAME="miusnrdasa"

# Token API Heroku Anda
HEROKU_API_TOKEN="HRKU-d27e3838-0234-498e-b068-92c6577fcf29"

# Panggil Heroku API untuk restart dynos
curl -X DELETE \
     -H "Authorization: Bearer $HEROKU_API_TOKEN" \
     -H "Accept: application/vnd.heroku+json; version=3" \
     https://api.heroku.com/apps/$APP_NAME/dynos
