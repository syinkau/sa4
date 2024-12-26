#!/bin/bash

# Wallet and worker configuration
WALLET="your-wallet-address"
WORKER="Worker001"
POOL_URL="stratum+tcp://$WALLET.$WORKER@pool-core-testnet.inichain.com:32672"

# Infinite loop to restart the miner if it stops
while true; do
  echo "Starting miner..."
  ./iniminer-linux-x64 --pool $POOL_URL

  # Check exit code of miner
  EXIT_CODE=$?
  echo "Miner crashed with exit code $EXIT_CODE. Restarting in 5 seconds..."
  sleep 5
done
