# Docker

Notes about Docker, Docker Compose, and Containers in general.

## Health Check

Health checks defined as `healthcheck` in `docker-compose.yaml` are getting executed **within the container**.

So even if the container in following example is not exposing any port, the health check will still be executed since
`localhost` here will be the containers IP address.

```yaml
healthcheck:
    test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
    interval: 30s
    timeout: 10s
    retries: 3
    start_period: 40s
```

