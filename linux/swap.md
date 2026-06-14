# Swap

## Check Status of Swap

```bash
swapon --show
free -h
```

## Create with Swap File

```bash
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

Add to `/etc/fstab`:

```bash
/swapfile none swap sw 0 0
```

Test it:

```bash
sudo swapoff /swapfile
sudo swapon -a
swapon --show
```
