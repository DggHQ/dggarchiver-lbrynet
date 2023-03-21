FROM python:3.7-slim-buster as builder
LABEL builder=true multistage_tag="dggarchiver-lbrynet-builder"
WORKDIR /build
RUN apt-get update
RUN apt-get install build-essential git libssl-dev libffi-dev -y
RUN pip install pyinstaller===4.6
RUN git clone https://github.com/lbryio/lbry-sdk.git --branch v0.113.0 --single-branch
RUN cd lbry-sdk && pip install -e . && pyinstaller --onefile --name lbrynet ./lbry/extras/cli.py

FROM debian:buster-slim
COPY --from=builder /build/lbry-sdk/dist/lbrynet /usr/local/bin/
COPY --from=builder /build/lbry-sdk/docker/webconf.yaml /
COPY entrypoint.sh /
RUN apt-get update && apt-get install ca-certificates openssl -y
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]