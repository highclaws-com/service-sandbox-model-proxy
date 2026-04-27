FROM rust:1-slim-bookworm AS builder

WORKDIR /src/clawshell
COPY clawshell ./
RUN cargo build --release --locked

FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/clawshell/target/release/clawshell /usr/local/bin/clawshell

RUN groupadd --system clawshell \
    && useradd --system --no-create-home --gid clawshell --shell /bin/sh clawshell \
    && mkdir -p /etc/clawshell/oauth /var/log/clawshell \
    && chown -R clawshell:clawshell /etc/clawshell /var/log/clawshell \
    && chmod 700 /etc/clawshell /var/log/clawshell

WORKDIR /app
CMD ["clawshell", "start", "--foreground", "-c", "/etc/clawshell/clawshell.toml"]
