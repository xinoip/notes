# WireGuard

The best VPN.

## Void Linux

Main package is `wireguard-tools`.

```sh
sudo xi -Su wireguard-tools
```

## Configuration

Configuration files stored in `/etc/wireguard`. For example, a config file named
`wg0.conf` will be stored in `/etc/wireguard/wg0.conf` and can be used with:

```sh
sudo wg-quick up wg0
sudo wg-quick down wg0
```
