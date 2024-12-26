#!/bin/bash

echo "Restarting dynos..."
curl -n -X DELETE https://api.heroku.com/apps/<app-name>/dynos \
    -H "Authorization: Bearer <HRKU-d27e3838-0234-498e-b068-92c6577fcf29>" \
    -H "Accept: application/vnd.heroku+json; version=3"
