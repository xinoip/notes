# Linux Server

Notes on Linux Server stuff.

## Auto Power on After Power Loss

Figure out your PCI device and field first:

```bash
lspci | grep ISA
> 00:1f.0 VGA compatible controller: Intel...
```

Example for intel based PCI device:

```bash
# Check if PCI device and field exist
sudo setpci -s 0:1f.0 0xa4.b

# Set it to 0
sudo setpci -s 0:1f.0 0xa4.b=0
```

## New Server Setup Checklist

- Debian [ISO setup](linux_dd.md)
- Ensure to disable root login.
- Create user with sudo.
- Update everything.
- UFW setup:

```sh
sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 2222/tcp # ssh
sudo ufw enable
```

- Harden SSH:

```conf
AllowUsers myuser
PermitRootLogin no
Port 2222
PasswordAuthentication no
PubkeyAuthentication yes
AuthorizedKeysFile /home/myuser/.ssh/authorized_keys
Banner /etc/issue.net
PermitEmptyPasswords no
UsePAM yes
X11Forwarding no
```

- Unattended upgrades:

```sh
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure unattended-upgrades
sudo systemctl edit apt-daily.timer
sudo systemctl edit apt-daily-upgrade.timer
sudo systemctl status apt-daily.timer
sudo systemctl status apt-daily-upgrade.timer
```

- Get Docker.
