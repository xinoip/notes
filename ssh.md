# SSH

Notes on SSH stuff.

## Ssh Port Forwarding

Forward port 8888 to port 9999 on the server:

```bash
ssh -L 8888:localhost:9999 user@server
```

This can be especially useful to forward database port to local port, so you can use GUI tools:

```bash
docker run -p 127.0.0.1:8888:5432 postgres
```

Connect to `localhost:8888` in your GUI tool.

## Lazy Load SSH Keys

Configure `~/.ssh/config` to load keys automatically based on `Host`:

```bash
Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa
```

## Separate SSH Keys for work and personal

SSH config file at `~/.ssh/config` is additive, meaning that it will start from
top of the file and try to match each `Host`. If a match is found, it doesn't
stop, instead, continues to the next `Host` in the file, until it reaches the
end of the file. Every match is added to the agents try list.

Negative match can be used to work around this behavior:

```bash
Host work
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa_work

Host * !work
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa_personal
```
