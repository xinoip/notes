# OpenWRT

```sh
# Show status of WAN interface
ifstatus wan
```

## Virtual Machine

Download `x86-64-generic-ext4-combined` image from [official OpenWRT downloads](https://downloads.openwrt.org/releases/).

```sh
gzip -dk openwrt-23.05.6-x86-64-generic-ext4-combined.img.gz
```

Set up virtual networks:

- `openwrt-wan`: NAT, IPv4 subnet: `192.168.100.0/24`, DHCP enabled
  with range `192.168.100.128-192.168.100.254`.
- `openwrt-lan`: Isolated, no DHCP, IPv6 optional.

Setup disk image:

```sh
# Attach as loopback device.
sudo losetup --find --show --partscan disk.img

# Manage partitions, resize root partition.
sudo gparted /dev/loop0

# Detach loopback device.
sudo losetup -d /dev/loop0
```

Create the VM:

- Select "Import existing disk image".
- 1 GB RAM, 2 CPUs.
- Make sure to select 'Customize configuration before install'.
- Use serial console to access the VM console.
- Add NIC: `openwrt-wan` with MAC ending in `01`.
- Add NIC: `openwrt-lan` with MAC ending in `02`.
- Remove all other NICs.
- Remove spice display. We will use serial console instead.
- Proceed with installation.

Make sure OpenWRT config is correct WAN and LAN wise:

```sh
uci show network
uci show network.@device[0]
```

Swap interfaces if necessary to fix WAN and LAN:

```sh
uci -q delete network.@device[0].ports
uci add_list network.@device[0].ports='eth1'

uci set network.lan.device='br-lan'
uci set network.lan.proto='static'
uci set network.lan.ipaddr='192.168.8.1'
uci set network.lan.netmask='255.255.255.0'

uci -q delete network.wan
uci set network.wan='interface'
uci set network.wan.device='eth0'
uci set network.wan.proto='dhcp'

uci commit network
/etc/init.d/network restart
```

Expected state:

```text
br-lan = 192.168.8.1/24, containing eth1
eth0   = DHCP address from openwrt-wan
default route via the openwrt-wan gateway
```

Later on create additional VMs that only has a single NIC connected to
`openwrt-lan`. These VMs will be behind the OpenWRT router.
