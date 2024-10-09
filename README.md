# xray-reality

## Installation Guide with Docker 

0. install docker 
``` bash
curl -fsSL https://get.docker.com | sh
```
1. clone this project 
``` bash
git clone https://github.com/Nyralei/xray-reality && cd xray-reality
```
2. build docker image 
``` bash
docker compose build
```
3. create `.env` file with the following content:
```
XRAY_PUBLIC_KEY=<generate with xray x25519>
XRAY_PRIVATE_KEY=<generate with xray x25519>
XRAY_UUID=<generate with xray uuid>
XRAY_SHORT_ID=<generate with openssl rand -hex 8>
XRAY_PORT=8000
XRAY_NAME=<whatever>
XRAY_EMAIL=<whatever you input here>
XRAY_SNI=<check with RealiTLScanner>
XRAY_PATH=%2F
```
4. run 
``` bash
 docker compose up -d
```
5. get connection config :
> get url
``` bash
docker exec -it xray-reality-xray-reality-1 cat /root/test.url
```
> view qrcode 
``` bash
docker exec -it xray-reality-xray-reality-1 sh -c 'qrencode -s 120 -t ANSIUTF8 $(cat /root/test.url)'
```