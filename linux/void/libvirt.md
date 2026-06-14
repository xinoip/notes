# Virtual Machines on Void Linux

```bash
xi -y libvirt qemu virt-manager virt-manager-tools virtiofsd
sudo ln -s /etc/sv/libvirtd /var/service
sudo ln -s /etc/sv/virtlockd /var/service
sudo ln -s /etc/sv/virtlogd /var/service
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
```
