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
3. run 
``` bash
 docker compose up -d
```
4. get connection config :
> get url
``` bash
docker exec -it xray-reality-xray-reality-1 cat /root/test.url
```
> view qrcode 
``` bash
docker exec -it xray-reality-xray-reality-1 sh -c 'qrencode -s 120 -t ANSIUTF8 $(cat /root/test.url)'
```