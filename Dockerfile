FROM node:20-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g @clawshell/clawshell

RUN groupadd --system clawshell \
    && useradd --system --no-create-home --gid clawshell --shell /usr/sbin/nologin clawshell \
    && mkdir -p /etc/clawshell /var/log/clawshell \
    && chown -R clawshell:clawshell /etc/clawshell /var/log/clawshell \
    && chmod 700 /etc/clawshell /var/log/clawshell

WORKDIR /app
USER clawshell
CMD ["clawshell", "start", "--foreground", "-c", "/etc/clawshell/clawshell.toml"]
