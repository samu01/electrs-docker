FROM rust:1.44.1-slim-buster
# FROM rust:latest AS builder

RUN apt-get update \
  && apt-get install -y --no-install-recommends clang=1:7.* cmake=3.* \
     libsnappy-dev=1.* \
  && apt-get install git-all \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-login --system --shell /bin/false --uid 1000 user

USER user
WORKDIR /home/user
# COPY ./ /home/user

RUN git clone https://github.com/romanz/electrs

RUN cargo install --path ./electrs

# Electrum RPC
EXPOSE 50001

# Prometheus monitoring
EXPOSE 4224

STOPSIGNAL SIGINT
