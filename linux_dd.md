# `dd` CLI

`dd` the disk destroyer.

## Make a Bootable USB Drive from ISO

Dummy write all the bytes to the USB drive. This doesn't work for Windows ISO. I am not sure if the issue is only limited to Windows or it exists for other ISO too.

```sh
sudo dd if=my-iso.iso of=/dev/sdX bs=4M status=progress
sync
```

Verify the ISO against SHA256 hash:

```sh
sudo head -c $(stat -c '%s' my-iso.iso) /dev/sdX | sha256sum -c SHA256SUMS.txt
```

Verify the SHA256SUMS signature:

```sh
gpg --verify SHA256SUMS.txt.asc SHA256SUMS.txt
```

Import keys:

```sh
gpg --keyserver hkps://keyring.debian.org:443 --recv-keys <key-id>
```
