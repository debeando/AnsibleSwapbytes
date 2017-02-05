#!/bin/bash
# encoding: UTF-8

if [ -z "$1" ]
  then echo -n "Enter new client common name (CN): "
  read -e CN
else
  CN=$1
fi

cd /etc/openvpn/rsa/
source ./vars.sh
./build-key ${CN}

echo "client" > /etc/openvpn/rsa/keys/${CN}.ovpn
echo "dev tun" >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo "proto udp" >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo "remote 138.68.64.72 1194" >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo "resolv-retry infinite" >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo "nobind" >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo "keepalive 10 60" >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo "comp-lzo" >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo '<ca>' >> /etc/openvpn/rsa/keys/${CN}.ovpn
cat /etc/openvpn/ca.crt >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo '</ca>' >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo '<cert>' >> /etc/openvpn/rsa/keys/${CN}.ovpn
cat /etc/openvpn/rsa/keys/${CN}.crt >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo '</cert>' >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo '<key>' >> /etc/openvpn/rsa/keys/${CN}.ovpn
cat /etc/openvpn/rsa/keys/${CN}.key >> /etc/openvpn/rsa/keys/${CN}.ovpn
echo '</key>' >> /etc/openvpn/rsa/keys/${CN}.ovpn

chown root:root /etc/openvpn/rsa/keys/${CN}.ovpn
cp /etc/openvpn/rsa/keys/${CN}.ovpn /root/
