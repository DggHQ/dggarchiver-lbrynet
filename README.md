# dggarchiver-lbrynet

Simple lbrynet dockerfile for dggarchiver needs.

Before using you need to make a ```videos``` volume.

Can be run using:
```bash
docker run --expose 5279 --name dggarchiver-lbrynet -v ./volumes/lbrynet/odysee_wallet:/wallet/wallets -v ./volumes/lbrynet/webconf.yaml:/webconf.yaml -v dggarchiver-lbrynet_wallet:/wallet -v dggarchiver-lbrynet_videos:/videos dgghq/dggarchiver-lbrynet:latest
```