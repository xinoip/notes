# Void Linux Post-Post Installation

At this point I have a working system that I can use and be happy with it. Why
stop there though?

## Enable Swapfile

Having a swap makes kernel happier: [[swap]]

## KDE Settings

Check out [[kde]] for more details.

## Change Bootloader: `gummiboot`

It's faster and more minimal than `grub`.

```bash
xi -y gummiboot
```

Update `/etc/fstab` so that boot partition is mounted on `/boot` and no longer
`/boot/efi`. Reboot to take effect. Now install the bootloader:

```bash
sudo bootctl install
```

Create entry config for void linux: `vim /boot/loader/void.conf`

```bash
root=/dev/nvme1n1p2 ro loglevel=0 console=tty2  udev.log_level=0 vt.global_cursor_default=0 mitigations=off nowatchdog
resume=UUID=<uuid-of-root-partition>
```

Find your kernel version and trigger a reconfigure:

```bash
sudo xbps-reconfigure -f linux<kernel-version>
```

Reboot and test. If it works, remove `grub` completely.

## Optimizing `fstab`

Remove `fsck` from all entries by setting final column number to `0`.

An example:

```bash
# <file system> <dir> <type> <options> <dump> <pass>
UUID=<id> / ext4 noatime 0 0
UUID=<id> /boot vfat umask=0077 0 0
tmpfs /tmp tmpfs noatime,nosuid,nodev,mode=1777 0 0
UUID=<id> /data ext4 noatime,nofail 0 0
/swapfile none swap sw 0 0
```
