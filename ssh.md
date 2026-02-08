# SSH

Notes on SSH stuff.

## SSH Port Forwarding

Forward port 8888 to port 9999 on the server:

```bash
ssh -L 8888:localhost:9999 user@server
```

This can be especially useful to forward database port to local port, so you can use GUI tools:

```bash
docker run -p 127.0.0.1:8888:5432 postgres
```

Connect to `localhost:8888` in your GUI tool.

