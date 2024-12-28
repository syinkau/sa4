#!/bin/bash

# Infinite loop to restart scripts if they stop
while true; do
  echo "Running start.sh..."
  ./input.sh &

  echo "Menjalankan node.sh..."
  bash /app/node.sh &

  echo "Running main.sh..."
  ./main.sh

  echo "Berikan jeda waktu 15 detik..."
  sleep 15
  
  echo "Start cron service..."
  service cron start
  
  echo "Scripts crashed. Restarting in 5 seconds..."
  sleep 5
done
