# NetworkManager on Void Linux

I had some weird problems while using NetworkManager on Void Linux. So noting
these down for future reference.

## Config

Set `/etc/NetworkManager/NetworkManager.conf` to:

```ini
[main]
plugins=keyfile
rc-manager=symlink

[connectivity]
enabled=true
uri=http://nmcheck.gnome.org/check_network_status.txt
response=NetworkManager is online
interval=300
```

Point the system resolver at NetworkManager:

```sh
sudo ln -sfn /run/NetworkManager/resolv.conf /etc/resolv.conf
sudo sv restart NetworkManager
```

Without these in place, NetworkManager can't control resolving. In result, you
can't connect to public Wi-Fi networks.

## Docker Network Collision

Docker bridge routes can hide real private addresses used by public Wi-Fi.
If a portal hostname resolves but reports `No route to host`, check:

```sh
getent ahosts portal.example.com
ip route get PORTAL_IP
docker network inspect $(docker network ls -q)
```

The portal IP must route through the Wi-Fi interface, not a Docker bridge.
Configure Docker address pools outside networks you commonly encounter, and
recreate any Docker networks that overlap.
