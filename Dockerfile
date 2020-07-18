FROM ekidd/rust-musl-builder as builder
COPY . .
RUN cargo install --path .

FROM alpine
ENV LISTEN_ADDR=0.0.0.0:3000 \
    SERVER_ADDR=9.9.9.9:53 \
    TIMEOUT=10 \
    MAX_CLIENTS=512
COPY --from=builder /home/rust/src/target/x86_64-unknown-linux-musl/release/doh-proxy /usr/local/bin/doh-proxy
ENTRYPOINT /usr/local/bin/doh-proxy -l $LISTEN_ADDR -c $MAX_CLIENTS -u $SERVER_ADDR -t $TIMEOUT
EXPOSE 3000

HEALTHCHECK --timeout=10s --interval=10s CMD wget -O /dev/null -q "http://$LISTEN_ADDR/dns-query?dns=AAABAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB"
