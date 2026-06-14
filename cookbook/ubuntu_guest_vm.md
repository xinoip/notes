# Ubuntu Guest VM

Best things to do on a new Ubuntu VM.

## Guest Support

Install these packages for support in the guest.

```bash
sudo apt update && sudo apt upgrade && sudo apt autoremove
sudo apt install -y qemu-guest-agent spice-vdagent openssh-server \
    vim
sudo systemctl enable --now ssh
```

## Shared Folder

Create a shared folder by adding new hardware in `virt-manager`. Select hardware
type "Filesystem" and use `virtiofsd` as the driver. Then in VM:

```bash
sudo mkdir -p /mnt/shared
# target-name is set in virt-manager
sudo mount -t virtiofs target-name /mnt/shared
```

Add it to `/etc/fstab` to make it permanent.

```bash
target-name /mnt/shared virtiofs defaults,nofail 0 0
```

## SSH Connection

Learn the IP address of the VM:

```bash
virsh domifaddr ubuntu-vm
```

Add host config to `~/.ssh/config`:

```bash
Host ubuntu-vm
    HostName 192.168.122.1
    User pio
    ControlMaster auto
    ControlPath ~/.ssh/cm-%r@%h:%p
    ControlPersist 10m
```

Then you can use it daily like:

```bash
virsh start ubuntu-vm
ssh ubuntu-vm
virt-viewer ubuntu-vm
```
