# Nexlayer build entrypoint (proxy overlay).
# The Nexlayer pipeline builds this root Dockerfile and pushes the proxy image.
# Reuses the upstream Gitpod proxy image (custom Caddy binary with all gitpod
# plugins) and swaps in a minimal plain-HTTP Caddyfile that routes to <pod>.pod
# upstreams (/ -> dashboard, /api -> server, /public-api -> public-api-server).
# Nexlayer's edge terminates TLS, so the proxy serves plain HTTP on :80.
FROM eu.gcr.io/gitpod-core-dev/build/proxy:main-gha.34374

COPY nexlayer-build/proxy/Caddyfile /etc/caddy/Caddyfile

USER root
RUN rm -rf /etc/caddy/vhosts && mkdir -p /etc/caddy/vhosts

EXPOSE 80
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
