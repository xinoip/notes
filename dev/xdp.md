# XDP

XDP (eXpress Data Path) is an advanced Linux kernel feature that works with
special eBPF programs to let you write programs working right in the network
interface card.

These notes were taken while following the [XDP Tutorial](https://github.com/xdp-project/xdp-tutorial).

## Loading an XDP Program

XDP programs can be loaded into network link interfaces. Use `ip link` to see
the status of those interfaces. `sudo ip link` is required to see the status of
a loaded XDP program on an interface.

There are various ways to load an XDP program:

- `ip` CLI: Quick and easy but not very flexible.
- `xdp-loader`: Provided by `xdp-tools` project.
- Custom loader: Write your own loader. Most flexible.

### `ip` CLI

```sh
sudo ip link set dev <interface> xdpgeneric obj my_prog.o sec xdp
sudo ip link show dev lo # Should show xdp program loaded
sudo ip link set dev lo xdpgeneric off # Disable xdp program
```

## XDP Actions

The action that is to be performed by kernel is communicated via program return
code. These are defined in enum `xdp_action`:

- `XDP_ABORTED`: Drops packet. Triggers `xdp:xdp_exception` tracepoint.
- `XDP_DROP`: Drops packet.
- `XDP_PASS`: Pass the packet to continue up the kernel network stack.
- `XDP_TX`: Re-transmits the packet out of the same interface.
- `XDP_REDIRECT`: Redirects packet to another interface.

## XDP Context Struct

Fields that are defined as `__u32` are pointers in disguise. For example, you
would cast the `data` and `data_end` fields before using them like this:

```c
void *data_end = (void *)(long)ctx->data_end;
void *data = (void *)(long)ctx->data;
```

The `data_end` field is used by "Verifier" to bound check. Verifier does a
static analysis at load time. It ensures the program stays in bounds.

## Network Byte Order

Packets comes straight off the wire for XDP programs. Use `bpf_ntohs` and
`bpf_htons` for byte order conversion. These are used instead of normal variants
because of some compilation quirks. See `bpf_endian.h` for more details.

## eBPF Programming Rules

- Use `bpf_ntohs` and `bpf_htons` for byte order conversion. (See
  `bpf_endian.h` for more details.)
- Use `__always_inline` for functions. eBPF programs have limited function call
  support.
- For looping, use `#pragma unroll`. (Newer eBPF supports for loop detection
  automatically.)
- Verifier runs at load time. It lives in kernel. Use `bpftool` to debug
  programs against verifier: `sudo bpftool -d prog load ./myprog.o
  /sys/fs/bpf/mytest`. Later on delete the test at path.
- If you get `failed to load: -13` or `permission denied: -13`, it means that
  verifier doesn't like you.
- The Verifier ensures all the accesses to the packet data are **bound
  checked**. This doesn't mean that there will be no out of bounds accesses. It
  means that if there is an out of bound access, program will handle it.

## VLAN Hardware Offload

In order to see VLAN tags as part of the packet, you need to disable VLAN
hardware offloading:

```sh
# Check current setting:
ethtool -k DEV | grep vlan-offload
# Disable for both RX and TX
ethtool --offload DEV rxvlan off txvlan off
# Same as:
# ethtool -K DEV rxvlan off txvlan off
```
