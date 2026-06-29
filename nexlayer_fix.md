# Nexlayer build pin — Gitpod multi-pod control plane

PINNED. Do NOT regenerate the Dockerfile or nexlayer.yaml.

The root `Dockerfile` is an intentional overlay on the published Gitpod server
image (`eu.gcr.io/gitpod-core-dev/build/server:main-gha.34374`). It bakes the
rendered `config.json`, the auth PKI signing keypair, and admin credentials into
`/config` + `/secrets` + `/credentials`, sets `CONFIG_PATH=/config/config.json`,
and runs DB schema migrations on boot before starting the server. This is the
real Gitpod server, deployed multi-pod (server + dashboard + mysql + redis),
addressed via `<pod>.pod:<port>`. Build the Dockerfile verbatim. Do not swap the
base image, do not regenerate from package.json, do not strip the ENTRYPOINT.
