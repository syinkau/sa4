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

# Download miner binary
COPY iniminer-linux-x64 /app/iniminer-linux-x64
RUN chmod +x /app/iniminer-linux-x64

# Copy startup script
COPY input.sh /app/input.sh
RUN chmod +x /app/input.sh

# Copy startup script
COPY main.sh /app/main.sh
RUN chmod +x /app/main.sh

# Copy startup script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set environment variables for Heroku compatibility
ENV PORT=8080

# Expose the port (Heroku expects this)
EXPOSE 8080

# Entry point
CMD ["/app/run.sh"]
