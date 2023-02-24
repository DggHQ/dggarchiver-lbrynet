FROM debian:bullseye-slim

ENV LBRY_VER=0.113.0

RUN apt-get update && apt-get upgrade -y && apt-get install -y zip wget cron
RUN wget https://github.com/lbryio/lbry-sdk/raw/master/docker/webconf.yaml -O /webconf.yaml
RUN wget https://github.com/lbryio/lbry-sdk/releases/download/v${LBRY_VER}/lbrynet-linux.zip && \
	unzip lbrynet-linux.zip -d /usr/bin && \
	chmod +x /usr/bin/lbrynet

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]