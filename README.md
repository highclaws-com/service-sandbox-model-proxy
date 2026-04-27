# Sandbox Model Proxy

A small Dockerized setup for running [Clawshell](https://www.npmjs.com/package/@clawshell/clawshell) as a model API proxy.

The image installs `@clawshell/clawshell`, runs it as an unprivileged `clawshell` user, and starts the proxy with the config mounted at `/etc/clawshell/clawshell.toml`.

## Run

Update `clawshell.toml` with real provider keys, then run:

```sh
docker run --rm \
  -p 18790:18790 \
  -v "$PWD/clawshell.toml:/etc/clawshell/clawshell.toml:ro" \
  sandbox-model-proxy
```

The proxy listens on port `18790` by default.
