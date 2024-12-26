# Base Image
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    bash \
    python3 \
    python3-pip \
    curl \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install Proxy Tools (e.g., Proxychains-ng for proxy configuration)
RUN apt-get update && apt-get install -y \
    proxychains4 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download miner binary
RUN wget https://github.com/Project-InitVerse/ini-miner/releases/download/v1.0.0/iniminer-linux-x64 >/dev/null 2>&1 \
    && chmod +x iniminer-linux-x64

# Copy and configure proxychains
COPY proxychains.conf /etc/proxychains4.conf

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Set environment variables for Heroku compatibility
ENV PORT=8080

# Expose the port (Heroku expects this)
EXPOSE 8080

# Entry point
CMD ["/app/start.sh"]
