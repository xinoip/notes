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

