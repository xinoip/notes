# Cloudflare

## Tunnel to Reverse Proxy

Using `cloudflared` tunnels, we can tunnel to a reverse proxy running on a local machine. This way, you don't need to
do specific configurations on Cloudflare web interface for each service you want to expose. This essentially exposes
`*.example.com` to your reverse proxy directly. You can specify what to expose in your reverse proxy configuration and
that configuration becomes only source of truth.

An example flow that's leveraging a singular Docker network containing `cloudflared` and `caddy` would be:

- Setup `cloudflared` and `caddy` in same Docker network. Don't expose any ports with Docker `-p` flag.
- Create a tunnel on web UI.
- Create a CNAME like `*.example.com` pointing to tunnel address.
- Under Zero Trust -> Network -> Connectors, find your tunnel.
- Under tunnel configuration, find "Published application routes".
- Add a single route like `*.example.com` and target service name of `http://caddy`.
- `cloudflared` should be able to resolve `http://caddy` through Docker network and forward traffic to `caddy`.

