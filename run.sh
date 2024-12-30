#!/bin/bash
# Infinite loop to restart the miner if it stops
while true; do
  echo "Starting miner..."
  
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
