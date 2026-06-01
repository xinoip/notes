# SCP

Securely copy files between hosts using SSH.

## Using SCP against Dropbear

`-O` flag is required when the target host doesn't have a modern server or uses
a minimal one such as Dropbear.

```sh
scp -O
```
