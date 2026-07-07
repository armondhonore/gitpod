# Nexlayer Gitpod proxy — reuses the upstream proxy image (custom Caddy binary
# with all gitpod plugins compiled in) and swaps in a minimal plain-HTTP Caddyfile
# that routes to <pod>.pod upstreams. Nexlayer's edge terminates TLS.
FROM eu.gcr.io/gitpod-core-dev/build/proxy:main-gha.34374

# Replace the TLS-requiring, installer-generated Caddyfile with our plain-HTTP one.
COPY Caddyfile /etc/caddy/Caddyfile

# Empty out the vhosts dir the upstream Caddyfile imported (we don't import it).
USER root
RUN rm -rf /etc/caddy/vhosts && mkdir -p /etc/caddy/vhosts

EXPOSE 80
# Run without the inject-ssh-tunnel adapter (no SSH gateway in this control-plane-only deploy).
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
