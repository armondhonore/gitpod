#!/bin/sh
# Nexlayer server entrypoint: run DB schema migrations (the gitpod-db tooling
# ships in this image), then start the server. Replaces the installer's separate
# db-migrations Job + database-waiter initContainer, neither of which Nexlayer's
# one-service-per-pod model provides.
set -e

echo "[entrypoint] waiting for database + running migrations..."
cd /app/node_modules/@gitpod/gitpod-db
yarn run wait-for-db
# migration:show is best-effort; migration:run is authoritative and idempotent.
yarn run typeorm migration:run || {
  echo "[entrypoint] migration:run failed; retrying once after 5s"
  sleep 5
  yarn run typeorm migration:run
}
echo "[entrypoint] migrations complete — starting server"

cd /app/node_modules/@gitpod/server
exec node ./dist/main.js
