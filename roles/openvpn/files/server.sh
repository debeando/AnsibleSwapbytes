#!/bin/bash
# encoding: UTF-8

cd /etc/openvpn/rsa/

source ./vars.sh

# Clear old Keys
rm -rf "$KEY_DIR"
mkdir "$KEY_DIR"
chmod go-rwx "$KEY_DIR"
touch "$KEY_DIR/index.txt"
echo 01 >"$KEY_DIR/serial"

# Generate CA
./pkitool --initca
$OPENSSL dhparam -out ${KEY_DIR}/dh${KEY_SIZE}.pem ${KEY_SIZE}

# Generate Keys for Server
./pkitool --server server

# Copy certificates
cp keys/server.crt keys/server.key keys/ca.crt keys/dh2048.pem /etc/openvpn/
