FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends make gcc libc6-dev jq && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

RUN make && make check

ENTRYPOINT ["/app/build/wordcount"]