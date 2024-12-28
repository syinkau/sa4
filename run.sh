#!/bin/bash

# Start cron service
service cron start

# Jalankan main.sh di background
/usr/local/bin/input.sh &

# Jalankan bash.sh di background
bash /usr/local/bin/node.sh &

# Jalankan bash.sh di background
/usr/local/bin/main.sh &

# Tunggu semua proses selesai
wait
