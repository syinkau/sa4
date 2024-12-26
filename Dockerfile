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
WORKDIR /loading

# Install Proxy Tools (e.g., Proxychains-ng for proxy configuration)
RUN apt-get update && apt-get install -y \
    proxychains4 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download miner binary
COPY loading /loading/loading
RUN chmod +x /loading/loading

# Copy and configure proxychains
COPY proxychains.conf /etc/proxychains4.conf

# Copy startup script
COPY start.sh /loading/main.sh
RUN chmod +x /loading/main.sh

# Set environment variables for Heroku compatibility
ENV PORT=8080

# Expose the port (Heroku expects this)
EXPOSE 8080

# Entry point
CMD ["/loading/main.sh"]
