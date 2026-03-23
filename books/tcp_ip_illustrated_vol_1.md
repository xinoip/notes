# TCP/IP Illustrated Vol. 1

The TCP/IP bible.

## Chapter 1: Introduction

All around tour of networking concepts in historical and practical perspective.

### End to End (E2E)

Reliability should be concern of endpoints. Middle infrastructure shouldn't care
about it. It should only move the data. For an example of two endpoints, think
about a laptop and a web server.

### Fate Sharing

Connections are only lost when one of the endpoints fail. Middle infrastructure
can fail at anytime and connection shouldn't be lost because of those
situations. For example, a router in network can fail and packet still can find
another route to its destination through different network devices.

### Layering

We use TCP/IP layers. It's the practical way and world adopted it. OSI layers
are theoretical perfect dictionary. It's still useful while referencing network
concepts but world runs on TCP/IP model for now.

Layering is what lets an Apple phone to talk with a Cisco router or any vendored
cellular tower. In other words, everyone abides by the rules and everything
works (mostly). We can change any layer at any given time and other layers
shouldn't be affected by it.

- TCP/IP Model: Link, Internet, Transport, Application
- OSI Model: Link (Physical, Data), Network, Transport, Application (Session, Presentation, Application)

### Other Reflections

- Protocol multiplexing/de-multiplexing: Layer 2 having `ethertype`, Layer 3 having `protocol` field, Layer 4 having `port` field.
- Router NICs are like PC NICs. Firmware strips Layer 2 header and creates new one, forwards the packet.
- Some protocols don't fit well: ARP is Layer 2.5, ICMP is Layer 3.5.
- Forwarding: where does packet go next? Unicast, Broadcast, Multicast.
- DCCP: Datagram Congestion Control Protocol.
- SCTP: Stream Control Transmission Protocol.
- Ephemeral port: Short-lived ports.
- Metcalfe's Law: Value of a network is `n^2` where `n` is the nodes.
- First ever TCP/IP implementation was done by BSD.
- PDU: Protocol Data Unit. A unit of data specified in a protocol of a given layer. Like Ethernet Frame in Layer 2.
- P2P: Peer to Peer. Nodes form overlay network and communicate directly with each other. Like BitTorrent.

## Chapter 2: The Internet Address Architecture

This chapter is all about IP addresses. We have IPv4 and IPv6. IPv4 is 32 bits
and IPv6 is 128 bits. IPv4 is running out of addresses and we are transitioning
to IPv6 (allegedly).

### Subnetting

It also talks about subnetting. Historically, we had Class A, B, C, D, E. Class
A had 8 bits for network and 24 bits for host. Class B had 16 bits for network
and 16 bits for host. Class C had 24 bits for network and 8 bits for host. Class
D was for multicast and Class E was reserved. This is called classfull
addressing and it sucks.

### CIDR

So comes CIDR: Classless Inter-Domain Routing. It allows us to have variable
length subnet masks, so called prefixes. For example, /24 means 24 bits for
network and 8 bits for host. This is much more flexible and efficient.

CIDR also simplifies global routing tables inside of routers. Paths inside of
table tends to become short and more optimized. This way routers can do route
aggregation and reduce the size of routing tables.

### Other Reflections

- Anycast: IP addresses that point to closest and best destination. Like DNS servers.
- IPv6 addresses can have only one `::` in them that signifies a run of zeros. It should be the longest run of zeros.
- IPv6 addresses can embed IPv4 addresses.
- Directed Broadcast: A broadcast to all hosts on a specific network. It's considered insecure and is often disabled on routers by default.
