#!/bin/bash -e

sudo wg-quick up wg0

cd ~/.wireguard

gpg --output privatekey --decrypt privatekey.gpg
gpgconf --reload gpg-agent
echo "Decrypting private key"

gpg --output presharedkey --decrypt presharedkey.gpg
gpgconf --reload gpg-agent
echo "Decrypting preshared key"

pubkey="$(sudo cat /etc/wireguard/publickey)"
sudo wg set wg0 private-key privatekey peer "$pubkey" preshared-key presharedkey

rm privatekey presharedkey
