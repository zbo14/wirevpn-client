#!/bin/bash -e

sudo add-apt-repository ppa:wireguard/wireguard
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get -y install resolvconf wireguard
