# UFW

Uncomplicated firewall on Linux.

## Install on Void Linux

```sh
xi -y ufw plasma-firewall
sudo ln -s /etc/sv/ufw /var/service
```

## Sane things to do

```sh
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed
sudo ufw logging low
sudo ufw enable

sudo ufw status verbose
```
