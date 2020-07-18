# doh-server

A fast and secure DoH (DNS-over-HTTPS) server written in Rust ([jedisct1/doh-server](https://github.com/jedisct1/doh-server)), dockerized.

## How to Run

Quickest way, using defaults:

```docker run --name doh-server --init --rm -p 3000:3000 neominik/doh-server```

Running with the `--init` option is recommended, so the process can terminate properly.

Options are configured with environment variables (which you can override with -e option). Defalt values:

```
LISTEN_ADDR 0.0.0.0:3000
SERVER_ADDR 9.9.9.9:53
TIMEOUT 10
MAX_CLIENTS 512
```

You should run the container behind a reverse proxy (such as traefik or nginx) to do SSL termination.

## Compose

Example `docker-compose.yml` file:

```yaml
version: '3.8'
services:

  doh-server:
    image: neominik/doh-server
    container_name: doh-server
    init: true
    environment:
      - LISTEN_ADDR: "0.0.0.0:3000"
      - SERVER_ADDR: "9.9.9.9:53"
      - TIMEOUT: 10
      - MAX_CLIENTS: 512
    restart: unless-stopped
```

## Clients

`doh-proxy` can be used with [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy)
as a client.
