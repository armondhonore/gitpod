# Nexlayer build entrypoint (server overlay).
# The Nexlayer pipeline builds this root Dockerfile and patches the resulting
# image into the `server` pod's "# filled by pipeline" placeholder in nexlayer.yaml.
# Bakes the rendered config.json + auth PKI keypair + admin creds into the
# published Gitpod server image, sets CONFIG_PATH, and runs DB migrations on boot.
FROM eu.gcr.io/gitpod-core-dev/build/server:main-gha.34374

USER root

COPY nexlayer-build/server/config.json /config/config.json
COPY nexlayer-build/server/secrets/auth-pki/signing/tls.key /secrets/auth-pki/signing/tls.key
COPY nexlayer-build/server/secrets/auth-pki/signing/tls.crt /secrets/auth-pki/signing/tls.crt
COPY nexlayer-build/server/credentials/admin/admin.json /credentials/admin/admin.json
COPY nexlayer-build/server/entrypoint.sh /nexlayer-entrypoint.sh
RUN chmod +x /nexlayer-entrypoint.sh

ENV CONFIG_PATH=/config/config.json
ENV DATABASE_TYPE=in-cluster
ENV NODE_ENV=production

EXPOSE 3000 3001
ENTRYPOINT ["/nexlayer-entrypoint.sh"]
