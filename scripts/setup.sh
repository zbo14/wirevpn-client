#!/bin/bash -e

if [ "$#" -lt 3 ]; then
  echo "Usage: setup <gateway> <ip> <pubkey>"
  exit 1
fi

sudo mkdir -p /etc/wireguard

mkdir -p ~/.wireguard
cd ~/.wireguard

umask 077
wg genkey > privatekey
wg pubkey < privatekey > publickey
wg genpsk > presharedkey

gpg --encrypt --sign privatekey
gpgconf --reload gpg-agent
echo "Encrypting private key"

rm privatekey

gpg --encrypt --sign presharedkey
gpgconf --reload gpg-agent
echo "Encrypting preshared key"

echo '[Interface]
Address = '"$2"'/32
DNS = 10.200.200.1

[Peer]
AllowedIPs = 0.0.0.0/0
Endpoint = '"$1"':51820
PersistentKeepalive = 25
PublicKey = '"$3" | sudo tee /etc/wireguard/wg0.conf > /dev/null

echo "$3" | sudo tee /etc/wireguard/publickey > /dev/null

echo "Client public key: $(cat publickey)"
echo "Preshared key: $(cat presharedkey)"

rm presharedkey
