# Net

Network stuff. Tools of trade.

## Layer 2 Traffic Generation

`netsniff-ng` provides lots of goodies. One of them is `trafgen` which is a simple traffic generator.

```sh
# Rate units can be: <num>pps/kpps/Mpps/B/kB/MB/GB/kbit/Mbit/Gbit/KiB/MiB/GiB (man trafgen)
trafgen --dev eth0 --conf packet.cfg --rate 1000KiB
```

Packet config has special syntax. An example can be found using `trafgen -e`.

## Layer 2 Interface Statistics

There are tools reading traffic counters of network devices on Linux:

- `iftop`: simple
- `bmon`: fancy
