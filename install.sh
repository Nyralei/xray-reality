#!/bin/bash

# Update package index and install dependencies
name=$XRAY_NAME
email=$XRAY_EMAIL
port=$XRAY_PORT
sni=$XRAY_SNI
path=$XRAY_PATH

json=$(cat config.json)

pk=$XRAY_PRIVATE_KEY
pub=$XRAY_PUBLIC_KEY
serverIp=$(curl -s ipv4.wtfismyip.com/text)
uuid=$XRAY_UUID
shortId=$XRAY_SHORT_ID

url="vless://$uuid@$serverIp:$port?type=tcp&encryption=none&flow=xtls-rprx-vision&sni=$sni&alpn=h2&fp=chrome&security=reality&pbk=$pub&sid=$shortId&packetEncoding=xudp#vless%2Btls%2Bh2%2Brealit"

newJson=$(echo "$json" | jq \
    --arg pk "$pk" \
    --arg uuid "$uuid" \
    --arg port "$port" \
    --arg sni "$sni" \
    --arg path "$path" \
    --arg email "$email" \
    '.inbounds[0].port= '"$(expr "$port")"' |
     .inbounds[0].settings.clients[0].email = $email |
     .inbounds[0].settings.clients[0].id = $uuid |
     .inbounds[0].streamSettings.realitySettings.dest = $sni + ":443" |
     .inbounds[0].streamSettings.realitySettings.serverNames += ["'$sni'"] |
     .inbounds[0].streamSettings.realitySettings.privateKey = $pk |
     .inbounds[0].streamSettings.realitySettings.shortIds += ["'$shortId'"]')

mkdir -p /usr/local/etc/xray/

echo "$newJson" | tee /root/config.json >/dev/null

echo "$url" >> /root/test.url

exit 0
