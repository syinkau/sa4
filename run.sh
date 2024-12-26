#!/bin/bash

# Jalankan start.sh di latar belakang
./input.sh &

# Jalankan main.sh di latar belakang
./main.sh &

# Tunggu semua proses selesai
wait
