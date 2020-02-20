# wirevpn-client

Some scripts to run a WireGuard VPN client on Ubuntu.

## Install

`$ sh scripts/install.sh`

This script installs WireGuard and [resolvconf](http://manpages.ubuntu.com/manpages/trusty/man8/resolvconf.8.html) (required for using VPN DNS).

## Setup

```
$ sh scripts/setup.sh <gateway> <ip> <pubkey>

Arguments:
  gateway  - the public IP address/hostname of the VPN server
  ip       - the desired tunnel IP address for the client
  pubkey   - the server's public key
```

This script does the following:

1. Generate public, private, and preshared keys and write them to `~/.wireguard`
1. Encrypt the private and preshared keys with GPG keys of your choosing
1. Write the WireGuard config and the server's public key to `/etc/wireguard`
1. Write the client's public key and unencrypted preshared key to stdout

## Start

`$ sh scripts/start.sh`

This script does the following:

1. Bring up the WireGuard interface
1. Decrypt your private and preshared keys with the GPG keys you chose
1. Set the private and preshared keys on the interface

## Stop

`$ sh scripts/stop.sh`

Bring down the WireGuard interface.
