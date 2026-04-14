# Docker

Notes about Docker, Docker Compose, and Containers in general.

## Health Check

Health checks defined as `healthcheck` in `docker-compose.yaml` are getting
executed **within the container**.

So even if the container in following example is not exposing any port, the
health check will still be executed since `localhost` here will be the
containers IP address.

```yaml
healthcheck:
    test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
    interval: 30s
    timeout: 10s
    retries: 3
    start_period: 40s
```

## Sudo Tweak

Linux requires `sudo` to interact with Docker client. Configure groups to not
require being root.

This is not really safe, in reality it makes whoever in `docker` group be
passwordless root!

```sh
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# logout/login to take effect
```

## Podman

Podman is hopefully better than Docker. It's everything that Docker should have
been it seems. Some day I'll explore the possibility of using Podman and it's
quadlets instead of Docker and compose.

### Default Registry

Docker uses `docker.io` as default registry. Podman doesn't assume anything and
wants fully qualified image names.

You can set the default registry to `docker.io`. Edit local config file at
`~/.config/containers/registries.conf`:

```toml
[registries.search]
registries = ['docker.io']
```

### Privileged Ports

Ports below 1024 are privileged ports. Obviously, Podman can't use them since it
runs without root. In order to use them, there are couple of options:

- Edit limit with `sysctl` (Now everything in system can use privileged ports)
- Run Podman as root (Kinda defeats the purpose of all these)
- Bind to ports higher than 1024 but use firewall rules to route traffic to
  lower ports

I'm going with first option for now but it bothers me since the only container
that needs privileged ports will be my reverse proxy or Pi-hole etc.

```bash
sysctl net.ipv4.ip_unprivileged_port_start=53
```

### Compose

There is `podman-compose` but it sucks for now it seems. I'm going to use
`docker-compose` for now. It needs a Docker socket to be present.

Enable the socket service of Podman:

```bash
systemctl --user enable --now podman.socket
```

Then install `docker-compose` (no need for `docker`) and use `podman compose`
command. It will locate the compose provider.
