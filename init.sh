#!/bin/bash

# install & start shadowsocks
pip install shadowsocks
sed -i 's/EVP_CIPHER_CTX_cleanup/EVP_CIPHER_CTX_reset/g' '/usr/local/lib/python3.9/site-packages/shadowsocks/crypto/openssl.py'
touch /etc/shadowsocks.json
chmod 777 /etc/shadowsocks.json
echo '{"server":"0.0.0.0","server_port":3121,"local_address": "127.0.0.1","local_port":1080,"password":"password","timeout":300,"method":"aes-256-cfb","fast_open": false,"workers": 1}' > /etc/shadowsocks.json
ssserver -c /etc/shadowsocks.json -d start

# open firewall
firewall-cmd --add-port=3121/tcp --permanent
firewall-cmd --add-port=34124/udp --permanent
firewall-cmd --reload

# install & start kcp
wget https://github.com/xtaci/kcptun/releases/download/v20210922/kcptun-linux-amd64-20210922.tar.gz
tar -xf kcptun-linux-amd64-20210922.tar.gz
nohup ./server_linux_amd64 -t "127.0.0.1:3121" -l ":34124" -mode fast3 -nocomp -sockbuf 16777217 -dscp 46 &
