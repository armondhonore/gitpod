# Nexlayer Gitpod server overlay: bakes the rendered config.json, the auth PKI
# signing keypair, and admin credentials into the published server image, sets
# CONFIG_PATH, and runs schema migrations on boot (the Nexlayer one-pod model has
# no separate db-migrations Job / database-waiter initContainer).
FROM eu.gcr.io/gitpod-core-dev/build/server:main-gha.34374

USER root

COPY config.json /config/config.json
COPY secrets/auth-pki/signing/tls.key /secrets/auth-pki/signing/tls.key
COPY secrets/auth-pki/signing/tls.crt /secrets/auth-pki/signing/tls.crt
COPY credentials/admin/admin.json /credentials/admin/admin.json
COPY entrypoint.sh /nexlayer-entrypoint.sh
RUN chmod +x /nexlayer-entrypoint.sh

ENV CONFIG_PATH=/config/config.json
ENV DATABASE_TYPE=in-cluster
ENV NODE_ENV=production

EXPOSE 3000 3001
ENTRYPOINT ["/nexlayer-entrypoint.sh"]
