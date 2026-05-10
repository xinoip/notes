# Void Linux Setup

Set up Void Linux on a new machine.

## GUI Installer

Just use the GUI installer. It's easy but lacks these features:

- Full disk encryption
- Satisfaction

Login as `root` with password `voidlinux`.

Command is: `void-installer`.

## Connect to the Internet

Wired connection doesn't need anything else. For Wi-Fi, use `wpa_cli`:

```bash
wpa_cli
add_network
# returns network number, e.g. 0
set_network 0 ssid "my-ssid"
set_network 0 psk "my-password"
enable_network 0
save config
quit
ping voidlinux.org
```

## Continue with SSH & Bash

Default live USB image already starts an SSH server. Connect to it with:

```sh
ssh anon@<ip-address>
# password: voidlinux
```

Switch to `root` user and use `bash` for better experience:

```sh
su - root
# password: voidlinux
bash
```

## Partitioning

I keep it simple. Just 2 partitions:

- `efi` for EFI boot partition, mounted at `/boot/efi`. 1G is good.
- `root` for the rest of the system, mounted at `/`. Rest of the space.
- I don't use `swap`.

Use these programs:

- `wipefs` to wipe filesystems.
- `cfdisk` to create partitions.
- `fdisk -l` to view partition details.
- `cfdisk -z` to zero out and write the partition table.
- `lsblk -f` to list block devices with filesystems and mount points.

In short, just do: `cfdisk -z /dev/nvme0n1`.

## Full Disk Encryption

I also keep this simple. Just encrypt the whole `root` partition with `LUKS2`:

```sh
cryptsetup luksFormat --type luks2 --pbkdf pbkdf2 /dev/nvme0n1p2
cryptsetup luksOpen --allow-discards /dev/nvme0n1p2 voidsec

mkfs.vfat -F 32 /dev/nvme0n1p1
mkfs.ext4 /dev/mapper/voidsec
```

From now on, root partition is `/dev/mapper/voidsec`. Boot partition is `/dev/nvme0n1p1`.

## Chroot Installation

Mount the partitions:

```sh
mount /dev/mapper/voidsec /mnt # if working with full disk encryption
# mount /dev/nvme0n1p2 /mnt # if not working with full disk encryption
mkdir -p /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi
```

Set the repo URL and architecture:

```sh
REPO=https://repo-default.voidlinux.org/current
ARCH=x86_64
```

Copy the RSA keys:

```sh
mkdir -p /mnt/var/db/xbps/keys
cp /var/db/xbps/keys/* /mnt/var/db/xbps/keys/
```

Bootstrap the system:

```sh
# Cryptsetup not needed if not using full disk encryption.
XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system cryptsetup grub-x86_64-efi
```

Create `/mnt/etc/fstab`:

```sh
xgenfstab -U /mnt > /mnt/etc/fstab
```

Chroot into the system:

```sh
xchroot /mnt /bin/bash
chown root:root /
chmod 755 /
```

Configure these:

```sh
echo "void" > /etc/hostname
ln -sf /usr/share/zoneinfo/Europe/Istanbul /etc/localtime
echo "en_US.UTF-8 UTF-8" > /etc/default/libc-locales
vi /etc/rc.conf # just go ever options
```

Generate locales:

```sh
xbps-reconfigure -f glibc-locales
```

Create the user:

```sh
visudo # uncomment the %wheel line
useradd -m -G wheel,audio,video,cdrom,input -s /bin/bash pio
passwd pio
su - pio
sudo su # test sudo access before locking down root
```

Lock down root:

```sh
passwd -l root
```

Configure `/etc/default/grub` for full disk encryption:

```sh
echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub
TMP_ENCRYPTED_PART_UUID=$(blkid -o value -s UUID /dev/nvme0n1p2)
echo "GRUB_CMDLINE_LINUX_DEFAULT=\"loglevel=4 rd.luks.uuid=${TMP_ENCRYPTED_PART_UUID} rd.luks.options=discard\"" >> /etc/default/grub
# remember to delete old GRUB_CMDLINE_LINUX_DEFAULT
```

Setup keys for full disk encryption:

```sh
dd bs=1 count=64 if=/dev/urandom of=/boot/volume.key
cryptsetup luksAddKey /dev/nvme0n1p2 /boot/volume.key
chmod 000 /boot/volume.key
echo "voidsec   UUID=${TMP_ENCRYPTED_PART_UUID}   /boot/volume.key   luks" >> /etc/crypttab
echo "install_items+=\" /boot/volume.key /etc/crypttab \"" > /etc/dracut.conf.d/10-crypt.conf
```

Install `grub`:

```sh
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Void" /dev/nvme0n1
```

Trigger a final reconfigure for all packages:

```sh
xbps-reconfigure -fa
```

Exit and reboot:

```sh
exit
umount -R /mnt
shutdown -r now
```
