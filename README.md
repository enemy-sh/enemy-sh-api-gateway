[![Deploy](https://github.com/enemy-sh/enemy-sh-api-gateway/actions/workflows/deploy.yml/badge.svg)](https://github.com/enemy-sh/enemy-sh-api-gateway/actions/workflows/deploy.yml)
# Enemy.sh Gateway API Configuration

This repository contains the **Caddyfile** for the Enemy.sh Gateway API. It serves as an API gateway to route traffic to internal microservices. The gateway centralizes traffic management and serves as a single point of entry.

## Overview

The Caddyfile:
- Logs requests in **JSON format**.
- Routes `/api/contact*` to the `enemy-sh-contact-api` internal service.
- Responds with **404 Not Found** for other routes.
- Allows new services to be added, ensuring all backend traffic is routed through this gateway.

## Current Routes

### `/api/contact*`
Routes traffic to the `enemy-sh-contact-api` service. Handles contact form submissions and forwards requests to the appropriate backend service.

## Configuration Details

### Logging
Logs requests in JSON format at `INFO` level:
```caddy
log {
    level INFO
    format json
    output stdout
}
```

### API Routing
Routes `/api/contact*` to `enemy-sh-contact-api` with headers for upstream processing:
```caddy
handle /api/contact* {
    reverse_proxy enemy-sh-contact-api {
        header_up X-Original-URL {http.request.uri}
        header_up X-Forwarded-Uri {http.request.uri}
        header_up X-Real-IP {http.request.header.X-Forwarded-For}
        header_up Host {http.reverse_proxy.upstream.hostport}
    }
}
```

### Default Response
Returns a `404 Not Found` for unmatched routes:
```caddy
handle {
    respond "Not Found" 404
}
```

### Adding New Services
To add new backend services, define additional routes in the Caddyfile. Each route should specify the path and the reverse proxy configuration for the target service. This ensures all services are accessible through this single gateway.

Example:
```caddy
handle /api/new-service* {
    reverse_proxy new-service {
        header_up X-Original-URL {http.request.uri}
        header_up Host {http.reverse_proxy.upstream.hostport}
    }
}
```

## Usage

1. **Install Caddy**: Download from [Caddy website](https://caddyserver.com/).
2. **Set Up Caddyfile**: Save the configuration as `Caddyfile`.
3. **Run Caddy**: Start the server:
   ```bash
   caddy run
   ```
4. **Access API Gateway**: Test with https://api.enemy.sh.

