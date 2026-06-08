# Reverse SSH Tunnel

This is especially useful when working with VM guests.

```bash
# Get dependencies on guest
sudo apt install -y openssh-server rsync build-essential

# Enable sshd on guest
sudo systemctl enable --now ssh

# Verify ping from guest to host
ping 10.0.2.2

# Make sure host also has sshd running

# Open tunnel on guest
ssh -N -R 2222:localhost:22 host_user@10.0.2.2

# Connect from host to guest
ssh -p 2222 guest_user@localhost

# Create an ~/.ssh/config entry for convenience
```

In order to sync stuff between host and guest, use `rsync` on the host.

```bash
rsync -avz --delete --exclude .git --exclude build -e 'ssh -p 2222' ./guest_user@localhost:~/synced
```
