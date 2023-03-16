FROM python:3.7-slim-buster as builder
LABEL builder=true multistage_tag="dggarchiver-lbrynet-builder"
RUN apt-get update
RUN apt-get install build-essential git libssl-dev libffi-dev -y
RUN git clone https://github.com/lbryio/lbry-sdk.git --branch v0.113.0 --single-branch
RUN cd lbry-sdk && make install


FROM debian:buster-slim
COPY --from=builder /usr/local/bin/lbrynet /usr/local/bin/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]