FROM ubuntu:24.04

LABEL maintainer="Nyralei" \
      version="0.1"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      jq \
      openssl \
      qrencode \
      tzdata \
      unzip && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Xray-core
RUN curl -L -H "Cache-Control: no-cache" -o /tmp/xray.zip \
        https://github.com/XTLS/Xray-core/releases/download/v25.1.30/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin/ && \
    rm /tmp/xray.zip && \
    chmod +x /usr/bin/xray

# Set working directory
WORKDIR /root/

# Copy configuration and scripts
COPY ./config.json ./config.json
COPY ./install.sh ./install.sh
COPY ./entrypoint.sh ./entrypoint.sh

# Ensure scripts are executable
RUN chmod +x install.sh entrypoint.sh

# Set the container entrypoint
ENTRYPOINT ["./entrypoint.sh"]

# Expose port 8000
EXPOSE 8000
