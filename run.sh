#!/bin/bash

# Infinite loop to restart scripts if they stop
while true; do
  echo "Running start.sh..."
  ./input.sh

  echo "Running main.sh..."
  ./main.sh

  echo "Scripts crashed. Restarting in 5 seconds..."
  sleep 5
done
