FROM ubuntu:24.04

LABEL maintainer="Nyralei"
LABEL version="0.1"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl unzip jq openssl qrencode unzip tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Install Xray-core
RUN curl -L -H "Cache-Control: no-cache" -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v1.8.1/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin/ && \
    rm /tmp/xray.zip && \
    chmod +x /usr/bin/xray
#end

WORKDIR /root/

COPY ./config.json ./config.json
COPY ./install.sh ./install.sh

EXPOSE 8000