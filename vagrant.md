# Vagrant

Easy, declarative, reproducible virtual machines.

## Void Linux

Void Linux requires a bit of setup:

```sh
# Packages on Void Linux
xi vagrant qemu libvirt libvirt-devel ruby-devel

# Enable libvirt services
sudo ln -s /etc/sv/libvirtd /var/service
sudo ln -s /etc/sv/virtlockd /var/service
sudo ln -s /etc/sv/virtlogd /var/service

# Setup vagrant without sudo
vagrant plugin install vagrant-libvirt
sudo usermod -aG libvirt $USER
newgrp libvirt
```
