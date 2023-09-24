#!/bin/bash
IP=$(~/gd/scripts/ip.sh)
rm ~/nsp/zool-release/tcpclient.conf
echo "user=zool" >> ~/nsp/zool-release/tcpclient.conf
echo "ip=192.168.1.$IP" >> ~/nsp/zool-release/tcpclient.conf
echo "port=3111" >> ~/nsp/zool-release/tcpclient.conf
unik -folder=/home/ns/nsp/zool-release
