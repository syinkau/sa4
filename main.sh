#!/bin/bash

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
