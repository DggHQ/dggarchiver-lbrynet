# lbrynet version
# https://github.com/lbryio/lbry-sdk/releases/latest
ARG LBRYNET_VERSION='v0.113.0'

# building lbrynet
FROM python:3.7-alpine3.16 as builder
LABEL builder=true multistage_tag="dggarchiver-lbrynet-builder"
ARG LBRYNET_VERSION
WORKDIR /build
RUN apk add --no-cache build-base libffi-dev openssl-dev musl-dev autoconf automake libtool git ca-certificates tzdata
RUN git clone https://github.com/lbryio/lbry-sdk.git --single-branch --branch ${LBRYNET_VERSION} .
RUN pip install pyinstaller===4.6 -e . && pyinstaller --onefile --name lbrynet ./lbry/extras/cli.py

# main image
FROM alpine:3.17
WORKDIR /app
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /build/dist/lbrynet /usr/bin/
COPY --from=builder /build/docker/webconf.yaml .
CMD ["lbrynet", "start", "--config=webconf.yaml"]