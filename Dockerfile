FROM python:3.7-slim-buster
RUN apt-get update
RUN apt-get install build-essential git libssl-dev -y
RUN git clone https://github.com/lbryio/lbry-sdk.git
RUN cd lbry-sdk && make install
RUN echo "Installed at $(which lbrynet)"
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]